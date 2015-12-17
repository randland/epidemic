require 'rspec/expectations'

RSpec::Matchers.define :default_property do |property|
  match do |klass|
    @options ||= {}
    @actual = klass.new(@options.except property).send(property)
    @actual == @val
  end

  chain :to do |val|
    @val = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected #{actual} to have property :#{expected} defaulted to #{@val} but found #{@actual}"
  end
end

RSpec::Matchers.define :default_hash_property do |property|
  match do |klass|
    @options ||= {}
    @actual = klass.new(@options.except property).send(property)
    @actual.deep_includes? @val
  end

  chain :to do |val|
    @val = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected #{actual} to have property :#{expected}\n defaulted to #{@val}\n but found #{@actual}\n diff: #{@val.deep_diff @actual}"
  end
end

RSpec::Matchers.define :allow_override_of do |property|
  match do |klass|
    @options ||= {}
    @actual = klass.new(@options.merge property => @val).send(property)
    @actual == @val
  end

  chain :to do |val|
    @val = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected #{actual} to allow override of property #{expected} to #{@val} but found #{@actual}"
  end
end

RSpec::Matchers.define :allow_hash_override_of do |property|
  match do |klass|
    @options ||= {}
    @actual = klass.new(@options.merge property => @val).send(property)
    @actual.deep_includes?(@val) && @actual.all? {|k,v| v.is_a? @as}
  end

  chain :to do |val|
    @val = val
  end

  chain :as do |as|
    @as = as
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected #{actual} to allow override of property #{expected} to #{@val} but found #{@actual}"
  end
end

RSpec::Matchers.define :coerce_objects_in do |property|
  match do |klass|
    @actual = klass.new(@options).send(property)
    @actual.values.first.is_a? @class
  end

  chain :to do |val|
    @class = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected #{actual} to coerce property #{expected} to #{@val} but found #{@actual.class}"
  end
end

RSpec::Matchers.define :coerce_override_of do |property|
  match do |klass|
    @actual = klass.new(@options.merge property => @override).send(property)
    @actual == @val
  end

  chain :from do |val|
    @override = val
  end

  chain :to do |val|
    @val = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected #{actual} to coerce property #{expected} to #{@val} from #{@override} but found #{@actual}"
  end
end

RSpec::Matchers.define :key_objects_in do |property|
  match do |klass|
    @stubbed_attrs ||= {}
    attrs = @stubbed_attrs.merge @keyed_on => 'foo'
    @actual = klass.new(@options.merge property => [attrs]).send(property)
    attrs.all? do |key, val|
      @actual.foo[key].to_s == val.to_s
    end
  end

  chain :on do |val|
    @keyed_on = val
  end

  chain :with_stubbed_attrs do |val|
    @stubbed_attrs = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected #{actual} to key property #{expected} on #{@keyed_on}"
  end
end

module PropertyMatcherHelpers
  def expect_attribute_required(attr, default_options={})
    expect do
      described_class.new default_options.merge attr => nil
    end.to raise_error(ArgumentError)
  end

  def expect_attribute_default(attr, default, default_options={})
    expect(described_class).to default_property(attr).to(default).when_initialized_with default_options
  end

  def expect_hash_attribute_default(attr, prototype, default_options={})
    config = Epidemic::DataModel.load_prototype prototype
    expect(described_class).to default_hash_property(attr).to(config).when_initialized_with default_options
  end

  def expect_attribute_override(attr, override, default_options={})
    expect(described_class).to allow_override_of(attr).to(override).when_initialized_with default_options
  end

  def expect_hash_attribute_type(attr, type, default_options={})
    expect(described_class).to coerce_objects_in(attr).to(type).when_initialized_with default_options
  end
  
  def expect_hash_attribute_keying(attr, keyed_on, stubbed_attrs, default_options={})
    expect(described_class).to key_objects_in(attr).on(keyed_on).with_stubbed_attrs(stubbed_attrs).when_initialized_with default_options
  end

  def expect_attribute_coercion(attr, override_hash, default_options={})
    override_hash.each do |from, to|
      expect(described_class).to coerce_override_of(attr).from(from).to(to).when_initialized_with default_options
    end
  end
end


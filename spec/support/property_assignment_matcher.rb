require 'rspec/expectations'

RSpec::Matchers.define :default_property do |property|
  match do |klass|
    @options ||= {}
    klass.new(@options.except property).send(property) == @val
  end

  chain :to do |val|
    @val = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected that #{actual} should have property #{expected} defaulted to #{@val}"
  end
end

RSpec::Matchers.define :allow_override_of do |property|
  match do |klass|
    klass.new(@options.merge property => @val).send(property) == @val
  end

  chain :to do |val|
    @val = val
  end

  chain :when_initialized_with do |options|
    @options = options
  end

  failure_message do |actual|
    "expected that #{actual} should allow override of property #{expected} to #{@val}"
  end
end

RSpec::Matchers.define :coerce_override_of do |property|
  match do |klass|
    klass.new(@options.merge property => @override).send(property) == @val
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
    "expected that #{actual} should allow override of property #{expected} to #{@val} from #{@override}"
  end
end

module PropertyMatcherHelpers
  def expect_attribute_required(attr, default_options={})
    expect {described_class.new default_options.merge(attr => nil)}.to raise_error(ArgumentError)
  end

  def expect_attribute_default(attr, default, default_options={})
    expect(described_class).to default_property(attr).to(default).when_initialized_with default_options
  end

  def expect_attribute_override(attr, override, default_options={})
    expect(described_class).to allow_override_of(attr).to(override).when_initialized_with default_options
  end

  def expect_attribute_coercion(attr, override_hash, default_options={})
    expect(described_class).to coerce_override_of(attr).from(override_hash.keys.first).to(override_hash.values.first).when_initialized_with default_options
  end
end


def property_assignment_shared_examples(type, attr, override:nil, coercions:{}, options:{})
  describe "##{attr}" do
    default_options = options[:default_options] || {}

    if required = options[:required]
      it "is required" do
        expect_attribute_required attr, default_options
      end
    end

    if options.has_key? :default
      default = options[:default]
      it "defaults to #{default}" do
        expect_attribute_default attr, default, default_options
      end
    elsif !required
      it "defaults to nil" do
        expect_attribute_default attr, nil, default_options
      end
    end

    it 'accepts overrides' do
      expect_attribute_override attr, override, default_options
    end

    it "coerces overrides to #{type}" do
      coercions.each do |from, to|
        expect_attribute_coercion attr, { from => to }, default_options
      end
    end
  end
end

property_types = {
  boolean: {
    override: true,
    coercions: { 1 => true,
                 0 => false,
                 'true' => true,
                 'false' => false }
  },
  integer: {
    override: 17,
    coercions: { '17' => 17 }
  },
  string: {
    override: 'some_string',
    coercions: { some_string: 'some_string' }
  },
  symbol: {
    override: :some_symbol,
    coercions: { 'some_symbol' => :some_symbol }
  },
  collection_of_integers: {
    override: [13, 17],
    coercions: { %w(13 17) => [13, 17] }
  },
  collection_of_strings: {
    override: %w(foo bar),
    coercions: { [:foo, :bar] => %w(foo bar) }
  },
  collection_of_symbols: {
    override: [:foo, :bar],
    coercions: { %w(foo bar) => [:foo, :bar] }
  }
}

property_types.each do |type, params|
  shared_examples_for "it has #{type.to_s.humanize.downcase} property" do |attr, options|
    property_assignment_shared_examples type, attr, params.merge(options: options)
  end
end

shared_examples_for "it has hash property" do |attr, options|
  describe "##{attr}" do
    default_options = options[:default_options] || {}

    if options.has_key? :of_type
      it "coerces objects to type #{options[:of_type]}" do
        expect_hash_attribute_type attr, options[:of_type], default_options
      end
    end

    if options.has_key? :keyed_on
      it "automatically keys new objects on #{options[:keyed_on]}" do
        expect_hash_attribute_keying attr, options[:keyed_on], options[:stubbed_attrs] || {}, default_options
      end
    end

    if options.has_key? :prototype
      it "defaults to loading the values found at /config/#{options[:prototype]}.yml" do
        expect_hash_attribute_default attr, options[:prototype], default_options
      end
    end
  end
end


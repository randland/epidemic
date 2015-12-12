def property_shared_examples(type, attr, override:nil, coercions:{}, options:{})
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
                 'y' => true,
                 'n' => false }
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
  }
}

property_types.each do |type, params|
  shared_examples_for "it has #{type} property" do |attr, options|
    property_shared_examples type, attr, params.merge(options: options)
  end
end

module Epidemic
  class Disease < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::Dash::PropertyTranslation

    property :color,
      required: true,
      coerce: Symbol
    property :available,
      default: 24,
      coerce: Integer
    property :cured,
      default: false,
      coerce: ->(val) { Epidemic.is_truthy? val }
    property :treated,
      default: false,
      coerce: ->(val) { Epidemic.is_truthy? val }
  end
end

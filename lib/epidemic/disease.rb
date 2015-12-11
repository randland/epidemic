module Epidemic
  class Disease < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :color,
      required: true,
      coerce: Symbol
  end
end

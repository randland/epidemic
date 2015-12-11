module Epidemic
  class City < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :tag,
      required: true,
      coerce: Symbol
    property :color,
      required: true,
      coerce: Symbol
  end
end


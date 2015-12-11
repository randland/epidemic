require 'epidemic/disease'

module Epidemic
  class Gamestate < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :diseases,
      default: { black: {}, blue: {}, red: {}, yellow: {} },
      coerce: ->(val) { Epidemic.coerce_objects val, to: Disease, via: :color }
  end
end


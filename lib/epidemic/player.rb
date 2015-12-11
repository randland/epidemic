require 'epidemic/player_card'

module Epidemic
  class Player < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :hand,
      default: [],
      coerce: Array[PlayerCard]

    property :location,
      default: :atlanta,
      coerce: Symbol

    property :move_behavior,
      default: DefaultPlayerMoveBehavior.name,
      coerce: ->(val) { Epidemic.coerce_class val }
  end
end

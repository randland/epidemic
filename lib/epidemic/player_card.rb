require 'epidemic/player_card_behavior'

module Epidemic
  class PlayerCard < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :color,
      coerce: Symbol

    property :city,
      coerce: Symbol

    property :card_behavior,
      default: PlayerCityCardBehavior.name,
      coerce: ->(val) { Epidemic.coerce_class val }
  end
end


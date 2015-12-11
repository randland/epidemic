require 'epidemic/infection_card_behavior'

module Epidemic
  class InfectionCard < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :city,
      coerce: Symbol

    property :card_behavior,
      default: InfectionCardBehavior.name,
      coerce: ->(val) { Epidemic.coerce_class val }
  end
end


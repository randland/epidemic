require 'epidemic/deck'

module Epidemic
  class InfectionDeck < Deck
    coerce_key :draw_pile, Array[InfectionCard]
    coerce_key :discard_pile, Array[InfectionCard]
  end
end


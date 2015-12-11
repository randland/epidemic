require 'epidemic/deck'

module Epidemic
  class PlayerDeck < Deck
    coerce_key :draw_pile, Array[PlayerCard]
    coerce_key :discard_pile, Array[PlayerCard]
  end
end


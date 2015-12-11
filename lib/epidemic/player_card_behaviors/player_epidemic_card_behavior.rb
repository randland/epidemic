module Epidemic
  class PlayerEpidemicCardBehavior < PlayerCardBehavior
    def self.card_drawn(gamestate, card)
      gamestate.player_deck.discard_pile << card
    end
  end
end

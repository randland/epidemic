module Epidemic
  class PlayerCardBehavior
    def self.card_drawn(gamestate, card)
      gamestate.current_player.hand << card
    end
  end
end

require 'epidemic/player_card_behaviors/player_city_card_behavior'
require 'epidemic/player_card_behaviors/player_epidemic_card_behavior'


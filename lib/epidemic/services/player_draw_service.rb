module Epidemic
  module Services
    module PlayerDrawService
      def self.draw(gamestate, count=1, player_index=nil)
        draw! gamestate.deep_clone, count, player
      end

      def self.draw!(gamestate, count=1, player_index=nil)
        count.times do
          card = gamestate.player_deck.shift
          card.draw_behavior.new(gamestate, card, player_index).perform!
        end
        gamestate
      end
    end
  end
end

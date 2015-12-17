module Epidemic
  module Services
    module InitialPlayerDealService
      def self.execute(gamestate)
        execute! gamestate.deep_clone
      end

      def self.execute!(gamestate)
        gamestate.players.each_index do |idx|
          PlayerDrawService.draw! gamestate, 2, idx
        end
        gamestate
      end
    end
  end
end


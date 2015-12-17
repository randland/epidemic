module Epidemic
  module Services
    module PopulatePlayerDeckService
      def self.execute(gamestate)
        execute! gamestate.deep_clone
      end

      def self.execute!(gamestate)
        deck = gamestate.cities.collect do |tag, city|
          Epidemic::PlayerCard.new city: tag, color: city.color
        end.shuffle
        gamestate.player_deck = deck
        gamestate
      end
    end
  end
end


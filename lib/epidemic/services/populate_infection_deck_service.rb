module Epidemic
  module Services
    module PopulateInfectionDeckService
      def self.execute(gamestate)
        execute! gamestate.deep_clone
      end

      def self.execute!(gamestate)
        deck = gamestate.cities.collect do |tag, city|
          Epidemic::InfectionCard.new city: tag, color: city.color
        end.shuffle
        gamestate.infection_deck = deck
        gamestate
      end
    end
  end
end


module Epidemic
  module Factories
    module GamestateFactory
      def self.create_game(options={})
        gamestate = Epidemic::Gamestate.new(options)
        generate_infection_deck(gamestate)
        draw_initial_infections(gamestate)
        gamestate
      end

      private

      def self.generate_infection_deck(gamestate)
        gamestate.infection_deck = 
          gamestate.cities.collect do |tag, city|
            InfectionCard.new city: tag, color: city.color
          end.shuffle
      end

      def self.draw_initial_infections(gamestate)
        3.times { DrawInfectionService.draw_infection!(gamestate, 3) }
        3.times { DrawInfectionService.draw_infection!(gamestate, 2) }
        3.times { DrawInfectionService.draw_infection!(gamestate, 1) }
      end
    end
  end
end


module Epidemic
  module Services
    module InitialInfectionService
      def self.execute(gamestate)
        execute! gamestate.deep_clone
      end

      def self.execute!(gamestate)
        3.times { InfectService.draw! gamestate, 3 }
        3.times { InfectService.draw! gamestate, 2 }
        3.times { InfectService.draw! gamestate }
        gamestate
      end
    end
  end
end


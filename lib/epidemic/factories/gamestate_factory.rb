module Epidemic
  module Factories
    class GamestateFactory
      attr_accessor :gamestate

      def self.create_game(options={})
        new(options).gamestate
      end

      private

      def initialize(total_epidemics: 5, **options)
        params = options.merge total_epidemics: total_epidemics
        self.gamestate = Epidemic::Gamestate.new params
      end
    end
  end
end


module Epidemic
  module Factories
    module GamestateFactory
      def self.create_game(options={})
        Epidemic::Gamestate.new(options)
      end
    end
  end
end

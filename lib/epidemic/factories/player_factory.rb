module Epidemic
  module Factories
    class PlayerFactory
      def self.civilian
        Epidemic::Player.new
      end

      def self.generalist
        Epidemic::Player.new actions_per_turn: 5
      end

      def self.medic
        Epidemic::Player.new treat_behavior: MedicTreatBehavior,
          enter_city_behavior: MedicEnterCityBehavior,
          in_city_behavior: MedicInCityBehavior
      end
    end
  end
end

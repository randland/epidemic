require_dir 'epidemic/action_behaviors'

module Epidemic
  class Player < DataModel
    property :actions_per_turn,
      default: 4,
      coerce: Integer

    property :location,
      default: :atlanta,
      coerce: Symbol

    property :move_behavior,
      default: DefaultMoveBehavior.name,
      coerce: ->(val) { coerce_class val }

    property :enter_city_behavior,
      default: NilBehavior.name,
      coerce: ->(val) { coerce_class val }

    property :in_city_behavior,
      default: DefaultInCityBehavior.name,
      coerce: ->(val) { coerce_class val }

    property :treat_behavior,
      default: DefaultTreatBehavior.name,
      coerce: ->(val) { coerce_class val }

    def available_actions(gamestate)
      result = []
      result += move_behavior.new(gamestate).available_actions
      result += treat_behavior.new(gamestate).available_actions
    end

    def move_to_location(location)
      self.location = location
    end
  end
end

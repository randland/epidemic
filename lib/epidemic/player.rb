module Epidemic
  class Player < DataModel
    property :role,
      coerce: Symbol

    property :hand,
      default: [],
      coerce: Array[PlayerCard]

    property :actions_per_turn,
      default: 4,
      coerce: Integer

    class_property :drive_ferry_behavior,
      default_class: Epidemic::DefaultDriveFerryBehavior
  end
end

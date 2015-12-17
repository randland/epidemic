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
  end
end

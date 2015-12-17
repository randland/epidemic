module Epidemic
  class PlayerCard < DataModel
    property :city,
      coerce: Symbol

    property :color,
      coerce: Symbol

    class_property :draw_behavior,
      default_class: PlayerCardDrawBehavior
  end
end

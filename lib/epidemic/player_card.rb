module Epidemic
  class PlayerCard < DataModel
    property :city,
      coerce: Symbol

    property :color,
      coerce: Symbol

    property :draw_behavior,
      coerce: ->(val) { coerce_class val }

    def draw_behavior
      self[:draw_behavior] || Epidemic::PlayerCardDrawBehavior
    end
  end
end

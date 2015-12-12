module Epidemic
  class Disease < DataModel
    property :color,
      required: true,
      coerce: Symbol

    property :available,
      required: true,
      default: 24,
      coerce: Integer

    property :cured,
      default: false,
      coerce: ->(val) { is_truthy? val }

    property :eradicated,
      default: false,
      coerce: ->(val) { is_truthy? val }
  end
end

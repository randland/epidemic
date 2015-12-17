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

    def cured?
      !!cured
    end

    property :eradicated,
      default: false,
      coerce: ->(val) { is_truthy? val }

    def eradicated?
      !!eradicated
    end

    property :infection_behavior,
      coerce: ->(val) { coerce_class val }

    def infection_behavior
      self[:infection_behavior] || DefaultDiseaseInfectionBehavior
    end
  end
end

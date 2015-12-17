module Epidemic
  class Disease < DataModel
    property :color,
      required: true,
      coerce: Symbol

    property :available,
      required: true,
      default: 24,
      coerce: Integer

    truthy_property :cured, default: false

    truthy_property :eradicated, default: false

    class_property :infection_behavior,
      default_class: DefaultDiseaseInfectionBehavior
  end
end

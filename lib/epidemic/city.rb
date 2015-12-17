module Epidemic
  class City < DataModel
    property :tag,
      required: true,
      coerce: Symbol

    property :color,
      required: true,
      coerce: Symbol

    property :name,
      coerce: String

    property :connections,
      default: [],
      coerce: Array[Symbol]

    def name
      self[:name] ||= tag.to_s.titleize
    end

    property :infections,
      default: {},
      coerce: Hash[Symbol => Integer]

    property :infection_behavior,
      coerce: ->(val) { coerce_class val }

    def infection_behavior
      self[:infection_behavior] || DefaultCityInfectionBehavior
    end
  end
end


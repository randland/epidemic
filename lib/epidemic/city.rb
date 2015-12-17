require_dir 'epidemic/infection_behaviors'

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

    property :infection_behavior,
      default: DefaultCityInfectionBehavior.name,
      coerce: ->(val) { coerce_class val }

    property :connections,
      default: [],
      coerce: Array[Symbol]

    property :infections,
      default: {},
      coerce: Hash[Symbol => Integer]

    def name
      self[:name] ||= tag.to_s.titleize
    end
  end
end


module Epidemic
  class City < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

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
      self[:name] ||= tag.to_s.split("_").map(&:downcase).map(&:capitalize).join(' ')
    end
  end
end


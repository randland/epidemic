module Epidemic
  class City < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::MethodAccessWithOverride

    property :tag,
      required: true,
      coerce: Symbol

    property :color,
      required: true,
      coerce: Symbol

    property :infections,
      default: {},
      coerce: Hash(Symbol => Integer)

    property :connections,
      default: [],
      coerce: Array[Symbol]

    property :name,
      coerce: String

    def name
      self[:name] || tag.to_s
    end

    def infect(infection_color=color)

    end

    def epidemic
    end
  end
end

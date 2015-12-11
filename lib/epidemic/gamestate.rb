require 'epidemic/city'
require 'epidemic/disease'
require 'yaml'

module Epidemic
  class Gamestate < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :diseases,
      default: Epidemic.load_yaml_config('diseases'),
      coerce: ->(val) { Epidemic.coerce_objects val, to: Disease, via: :color }

    property :cities,
      default: Epidemic.load_yaml_config('cities'),
      coerce: ->(val) { Epidemic.coerce_objects val, to: City, via: :tag }

    def cities_connected_to(city)
      cities[city].connections
    end
  end
end


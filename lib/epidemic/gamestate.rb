require 'epidemic/city'
require 'epidemic/disease'

module Epidemic
  class Gamestate < DataModel
    property :diseases,
      default: load_yaml_config('diseases'),
      coerce: ->(val) { coerce_objects val, to: Disease, via: :color }

    property :cities,
      default: load_yaml_config('cities'),
      coerce: ->(val) { coerce_objects val, to: City, via: :tag }

    def cities_connected_to(city)
      cities[city].connections
    end
  end
end


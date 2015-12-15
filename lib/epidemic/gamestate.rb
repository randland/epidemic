require 'epidemic/data_model'
require 'epidemic/city'
require 'epidemic/disease'

module Epidemic
  class Gamestate < DataModel
    property :max_outbreaks,
      default: 7,
      coerce: Integer
    property :outbreaks,
      default: 0,
      coerce: Integer

    property :total_epidemics,
      default: 5,
      coerce: Integer
    property :played_epidemics,
      default: 0,
      coerce: Integer

    property :infection_rates,
      default: [2, 2, 2, 3, 3, 4, 4],
      coerce: Array[Integer]

    def infection_rate
      infection_rates[played_epidemics || 0]
    end

    property :diseases,
      default: load_yaml_config('diseases'),
      coerce: ->(val) { coerce_objects val, to: Disease, via: :color }

    property :cities,
      default: load_yaml_config('cities'),
      coerce: ->(val) { coerce_objects val, to: City, via: :tag }

    def cities_connected_to(city)
      cities.slice *cities[city].connections
    end
  end
end


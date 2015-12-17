require 'epidemic/data_model'
require_dir 'epidemic/infection_behaviors'
require_dir 'epidemic/card_draw_behaviors'
require_dir 'epidemic/player_behaviors'
require 'epidemic/city'
require 'epidemic/disease'
require 'epidemic/infection_card'
require 'epidemic/player_card'
require 'epidemic/player'

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

    property :infection_deck,
      default: [],
      coerce: Array[InfectionCard]

    property :infection_discard,
      default: [],
      coerce: Array[InfectionCard]

    tagged_property :diseases,
      prototype: 'diseases',
      coerce: {color: Disease}

    tagged_property :cities,
      prototype: 'cities',
      coerce: {tag: City}

    def cities_connected_to(city)
      cities.slice *cities[city].connections
    end

    property :player_deck,
      default: [],
      coerce: Array[PlayerCard]

    property :player_discard,
      default: [],
      coerce: Array[PlayerCard]

    property :players,
      default: [],
      coerce: Array[Player]

    property :turn,
      default: 0,
      coerce: Integer

    property :actions_used,
      default: 0,
      coerce: Integer

    def current_player
      players.values[turn % players.count]
    end
  end
end


require "epidemic/city"
require "epidemic/disease"
require "epidemic/player"
require "epidemic/decks/player_deck"

module Epidemic
  class Gamestate < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :players,
      default: [{},{},{},{}],
      coerce: Array[Player]
    property :turn,
      default: 0,
      coerce: Integer
    property :actions_used,
      default: 0,
      coerce: Integer

    def current_player
      players[turn % players.count]
    end

    property :max_outbreaks,
      default: 8,
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
      infection_rates[played_epidemics]
    end

    property :diseases,
      default: {blue: {}, yellow: {}, red: {}, black: {}},
      coerce: ->(val) { Epidemic.coerce_objects val, to: Disease, via: :color }

    property :cities,
      default: {
        atlanta: {color: :blue},
        washington: {color: :blue},
        montreal: {color: :blue},
        chicago: {color: :blue},
        new_york: {color: :blue},
        madrid: {color: :blue},
        essen: {color: :blue},
        milan: {color: :blue},
        london: {color: :blue},
        st_petersburg: {color: :blue},
        san_fransisco: {color: :blue},
        paris: {color: :blue},
        los_angeles: {color: :yellow},
        miami: {color: :yellow},
        mexico_city: {color: :yellow},
        bogota: {color: :yellow},
        lima: {color: :yellow},
        santiago: {color: :yellow},
        sau_paulo: {color: :yellow},
        lagos: {color: :yellow},
        kinshasa: {color: :yellow},
        johannesberg: {color: :yellow},
        buenos_aires: {color: :yellow},
        khartoum: {color: :yellow},
        algiers: {color: :black},
        cairo: {color: :black},
        istanbul: {color: :black},
        moscow: {color: :black},
        baghdad: {color: :black},
        riyadh: {color: :black},
        kolkata: {color: :black},
        delhi: {color: :black},
        karachi: {color: :black},
        mumbai: {color: :black},
        chennai: {color: :black},
        tehran: {color: :black},
        bangkok: {color: :red},
        beijing: {color: :red},
        seoul: {color: :red},
        tokyo: {color: :red},
        osaka: {color: :red},
        shanghai: {color: :red},
        sydney: {color: :red},
        manilla: {color: :red},
        tai_pei: {color: :red},
        hong_kong: {color: :red},
        ho_chi_minh_city: {color: :red},
        jakarta: {color: :red}
      },
      coerce: ->(val) { Epidemic.coerce_objects val, to: City, via: :tag }

    def cities_connected_to(city_tag)
      cities.slice *cities[city_tag].connections
    end

    property :player_deck,
      default: {draw_pile: [], discard_pile: []},
      coerce: ->(val) do
        case val
        when Array then PlayerDeck.new(draw_pile: val, discard_pile: [])
        else PlayerDeck.new val
        end
      end

    def draw_player_card
      player_deck.draw(self)
    end
  end
end


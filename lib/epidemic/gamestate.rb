require 'epidemic/city'
require 'epidemic/disease'

module Epidemic
  class Gamestate < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :diseases,
      default: {
        black: {},
        blue: {},
        red: {},
        yellow: {}
      },
      coerce: ->(val) { Epidemic.coerce_objects val, to: Disease, via: :color }

    property :cities,
      default: {
        algiers: {color: :black},
        atlanta: {color: :blue},
        baghdad: {color: :black},
        bangkok: {color: :red},
        bejing: {color: :red},
        bogota: {color: :yellow},
        buenos_aires: {color: :yellow},
        cairo: {color: :black},
        chennai: {color: :black},
        chicago: {color: :blue},
        delhi: {color: :black},
        essen: {color: :blue},
        ho_chi_minh_city: {color: :red},
        hong_kong: {color: :red},
        istanbul: {color: :black},
        jakarta: {color: :red},
        johannesburg: {color: :yellow},
        karachi: {color: :black},
        khartoum: {color: :yellow},
        kinshasa: {color: :yellow},
        kolkata: {color: :black},
        lagos: {color: :yellow},
        lima: {color: :yellow},
        london: {color: :blue},
        los_angeles: {color: :yellow},
        madrid: {color: :blue},
        manila: {color: :red},
        mexico_city: {color: :yellow},
        miami: {color: :yellow},
        milan: {color: :blue},
        montreal: {color: :blue},
        moscow: {color: :black},
        mumbai: {color: :black},
        new_york: {color: :blue},
        osaka: {color: :red},
        paris: {color: :blue},
        riyadh: {color: :black},
        san_francisco: {color: :blue},
        santiago: {color: :yellow},
        sao_paulo: {color: :yellow},
        seoul: {color: :red},
        shanghai: {color: :red},
        st_petersburg: {color: :blue},
        sydney: {color: :red},
        taipei: {color: :red},
        tehran: {color: :black},
        tokyo: {color: :red},
        washington: {color: :blue}
      },
      coerce: ->(val) { Epidemic.coerce_objects val, to: City, via: :tag }
  end
end


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
        algiers: {},
        atlanta: {},
        baghdad: {},
        bangkok: {},
        bejing: {},
        bogota: {},
        buenos_aires: {},
        cairo: {},
        chennai: {},
        chicago: {},
        delhi: {},
        essen: {},
        ho_chi_minh_city: {},
        hong_kong: {},
        istanbul: {},
        jakarta: {},
        johannesburg: {},
        karachi: {},
        khartoum: {},
        kinshasa: {},
        kolkata: {},
        lagos: {},
        lima: {},
        london: {},
        los_angeles: {},
        madrid: {},
        manila: {},
        mexico_city: {},
        miami: {},
        milan: {},
        montreal: {},
        moscow: {},
        mumbai: {},
        new_york: {},
        osaka: {},
        paris: {},
        riyadh: {},
        san_francisco: {},
        santiago: {},
        sao_paulo: {},
        seoul: {},
        shanghai: {},
        st_petersburg: {},
        sydney: {},
        taipei: {},
        tehran: {},
        tokyo: {},
        washington: {}
      },
      coerce: ->(val) { Epidemic.coerce_objects val, to: City, via: :tag }
  end
end


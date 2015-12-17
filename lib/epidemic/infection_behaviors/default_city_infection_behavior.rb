module Epidemic
  class DefaultCityInfectionBehavior < Hashie::Mash
    def initialize(gamestate, city_tag)
      self.gamestate = gamestate
      self.city_tag = city_tag
    end

    def city
      gamestate.cities[city_tag]
    end

    def disease
      gamestate.diseases[city.color]
    end

    def infect(count=1)
      self.gamestate = gamestate.deep_clone
      infect! count
    end

    def infect!(count=1)
      disease.infection_behavior.new(gamestate, city_tag).infect! count
    end
  end
end

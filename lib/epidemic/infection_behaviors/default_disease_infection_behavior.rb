module Epidemic
  class DefaultDiseaseInfectionBehavior
    attr_accessor :gamestate, :city_tag

    def initialize(gamestate, city_tag)
      self.gamestate = gamestate
      self.city_tag = city_tag
    end

    def infect(count=1)
      self.gamestate = gamestate.deep_clone
      infect! count
    end

    def infect!(count=1, city_override=city_tag)
      return gamestate if disease.eradicated?
      gamestate.cities[city_override].tap do |this_city|
        this_city.infections ||= {}
        this_city.infections[color] ||= 0
        count.times do
          if this_city.infections[color] >= 3
            outbreak! this_city.tag
            return gamestate
          else
            disease.available -= 1
            this_city.infections[color] += 1
          end
        end
      end
      gamestate
    end

    private

    def city
      gamestate.cities[city_tag]
    end

    def disease
      gamestate.diseases[city.color]
    end

    def color
      disease.color
    end

    def outbreak!(city_override)
      @outbreak_cities ||= []
      return if @outbreak_cities.include? city_override
      @outbreak_cities << city_override
      gamestate.outbreaks += 1
      gamestate.cities_connected_to(city_override).each do |tag, connected_city|
        infect!(1, tag)
      end
    end
  end
end


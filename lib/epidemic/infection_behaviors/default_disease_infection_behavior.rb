module Epidemic
  class DefaultDiseaseInfectionBehavior < Hashie::Mash
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

    def color
      disease.color
    end

    def infect!(count=1, city_override=city_tag)
      gamestate.cities[city_override].tap do |this_city|
        this_city.infections ||= {}
        this_city.infections[color] ||= 0
        return gamestate if player_blocks_infection? this_city
        count.times do
          if this_city.infections[color] >= 3
            outbreak!(this_city.tag)
            return gamestate
          else
            disease.available -= 1
            this_city.infections[color] += 1
          end
        end
      end
      gamestate
    end

    def player_blocks_infection?(this_city)
      players_in_city = gamestate.players.select {|p| p.location = this_city.tag}
      return false if players_in_city.empty?
      !players_in_city.all? {|p| p.in_city_behavior.new(gamestate, p).can_infect? color}
    end

    def outbreak!(city_tag)
      @outbreak_cities ||= []
      return if @outbreak_cities.include? city_tag 
      @outbreak_cities << city_tag
      gamestate.outbreaks += 1
      gamestate.cities_connected_to(city_tag).each do |tag, connected_city|
        infect!(1, tag)
      end
    end
  end
end

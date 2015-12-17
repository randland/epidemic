module Epidemic
  module Services
    module InfectService
      def self.draw(gamestate, count=1)
        draw! gamestate.deep_clone, count
      end

      def self.draw!(gamestate, count=1)
        card = gamestate.infection_deck.shift
        gamestate.infection_discard.unshift card
        infect! gamestate, card.city, count
        gamestate
      end

      def self.infect(gamestate, city_tag, count=1)
        infect! gamestate.deep_clone, city_tag, count
      end

      def self.infect!(gamestate, city_tag, count=1)
        city = gamestate.cities[city_tag]
        city.infection_behavior.new(gamestate, city.tag).infect! count
        gamestate
      end
    end
  end
end

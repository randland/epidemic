module Epidemic
  module Services
    module EpidemicService
      def self.draw(gamestate)
        draw! gamestate.deep_clone
      end

      def self.draw!(gamestate)
        card = gamestate.infection_deck.pop
        gamestate.infection_discard.unshift card
        infect! gamestate, card.city
        intensify_infections! gamestate
        gamestate
      end

      private

      def self.infect!(gamestate, city_tag)
        gamestate.played_epidemics += 1
        city = gamestate.cities[city_tag]
        city.infection_behavior.new(gamestate, city.tag).infect! 3
      end

      def self.intensify_infections!(gamestate)
        gamestate.infection_deck = gamestate.infection_discard.shuffle + gamestate.infection_deck
        gamestate.infection_discard = []
        gamestate.infection_rate.times { InfectService.draw! gamestate }
      end
    end
  end
end

module Epidemic
  class DrawEpidemicService
    def self.draw_epidemic(gamestate)
      draw_epidemic! gamestate.deep_clone
    end

    def self.draw_epidemic!(gamestate)
      card = gamestate.infection_deck.pop
      gamestate.infection_discard.unshift card
      city = gamestate.cities[card.city]
      city.infection_behavior.new(gamestate, card.city).infect! 3
      gamestate.played_epidemics += 1
      gamestate.infection_deck.unshift(gamestate.infection_discard.shuffle).flatten!
      gamestate.infection_discard = []
      gamestate.infection_rate.times do
        DrawInfectionService.draw_infection! gamestate
      end
      gamestate
    end
  end
end

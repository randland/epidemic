module Epidemic
  class DrawInfectionService
    def self.draw_infection(gamestate, count=1)
      draw_infection! gamestate.deep_clone, count
    end

    def self.draw_infection!(gamestate, count=1)
      card = gamestate.infection_deck.shift
      gamestate.infection_discard.unshift card
      city = gamestate.cities[card.city]
      city.infection_behavior.new(gamestate, card.city).infect!(count)
    end
  end
end

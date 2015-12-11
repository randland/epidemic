module Epidemic
  class InfectionCardBehavior
    def self.card_drawn(gamestate, card)
      gamestate.infection_deck.discard_pile << card
      city = gamestate.cities[card.city]
      city.add_infection(city.color)
    end

    def self.card_drawn_as_epidemic(gamestate, card)
      gamestate.infection_deck.discard_pile << card
    end
  end
end


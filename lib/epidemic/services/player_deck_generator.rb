module Epidemic
  class PlayerDeckGenerator
    attr_accessor :gamestate, :deck

    def self.generate_player_deck_for(gamestate)
      self.new(gamestate).send :generate_player_deck
    end

    private

    def initialize(gamestate)
      self.gamestate = gamestate
    end

    def generate_player_deck
      generate_city_cards
      add_event_cards
      shuffle_deck
      deal_to_players
      add_epidemics
      save_deck_to_gamestate
      gamestate
    end

    def generate_city_cards
      self.deck = gamestate.cities.collect do |city_tag, city|
        {city: city_tag, color: city.color}
      end
    end

    def add_event_cards(cards=[])
      self.deck += cards
    end

    def shuffle_deck
      deck.shuffle!
    end

    def deal_to_players
      num_to_deal = [0, 4, 4, 3, 2, 2][gamestate.players.count]

      gamestate.players.each do |player|
        player.hand = num_to_deal.times.collect { deck.shift }
      end
    end

    def add_epidemics
      self.deck = deck.in_groups(gamestate.total_epidemics, false).collect do |pile|
        pile << {card_behavior: PlayerEpidemicCardBehavior}
        pile.shuffle
      end.flatten
    end

    def save_deck_to_gamestate
      gamestate.player_deck.draw_pile = deck
    end
  end
end

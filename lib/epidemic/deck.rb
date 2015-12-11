module Epidemic
  class Deck < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    property :draw_pile,
      default: []

    property :discard_pile,
      defaults: []

    def draw(gamestate)
      card = draw_pile.shift
      card.card_behavior.card_drawn(gamestate, card)
    end
  end
end

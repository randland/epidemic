module Epidemic
  class DefaultInCityBehavior < Hashie::Mash
    def initialize(gamestate, player)
      self.gamestate = gamestate
      self.player = player
    end

    def can_infect?(color)
      true
    end
  end
end

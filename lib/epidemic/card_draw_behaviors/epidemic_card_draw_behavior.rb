module Epidemic
  class EpidemicCardDrawBehavior
    attr_accessor :gamestate, :card

    def initialize(gamestate, card, player_index=nil)
      self.gamestate = gamestate
      self.card = card
    end

    def perform
      self.gamestate = gamestate.deep_clone
      perform!
    end

    def perform!
      gamestate.player_discard.unshift card
      Epidemic::Services::EpidemicService.draw! gamestate
    end
  end
end

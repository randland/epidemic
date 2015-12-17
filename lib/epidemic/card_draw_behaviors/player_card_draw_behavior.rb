module Epidemic
  class PlayerCardDrawBehavior
    attr_accessor :gamestate, :card, :player_index

    def initialize(gamestate, card, player_index=nil)
      self.gamestate = gamestate
      self.card = card
      self.player_index = player_index || (gamestate.turn % gamestate.players.count)
    end

    def perform
      self.gamestate = gamestate.deep_clone
      perform!
    end

    def perform!
      player.hand.push card
      gamestate
    end

    private

    def player
      gamestate.players[player_index]
    end
  end
end

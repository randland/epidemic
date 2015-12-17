module Epidemic
  class MedicEnterCityBehavior < Hashie::Mash
    def self.execute!(gamestate, player)
      self.new(gamestate, player).execute!
    end

    def initialize(gamestate, player)
      self.gamestate = gamestate
      self.player = player
    end

    def execute!
      gamestate.cities[player.location].infections.tap do |infections|
        gamestate.diseases.values.select(&:cured).each do |disease|
          qty = infections[disease.color] || 0
          infections[disease.color] = 0
          disease.available += qty
        end
      end
      gamestate
    end
  end
end

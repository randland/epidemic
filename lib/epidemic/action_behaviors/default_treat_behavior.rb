module Epidemic
  class DefaultTreatBehavior < ActionBehavior
    def initialize(gamestate)
      self.gamestate = gamestate
      self.player = gamestate.current_player
    end

    def available_actions
      result = []
      result += treat_actions
    end

    private

    def applicable_cities
      [player_city]
    end

    def player_city
      gamestate.cities[player.location]
    end

    def treat_actions
      @treat_actions ||=
        applicable_cities.collect do |city|
          city.infections.collect do |color, qty|
            if qty > 0
              ActionCommand.new(behavior: self.class,
                                action: :treat,
                                args: { city: city.tag,
                                        color: color }
                               )
            else
              nil
            end
          end
        end.flatten.compact
    end

    def treat(color: player_city.color, city: player_city.tag)
      raise NothingToTreateException unless treat_city_valid? color: color, city: city
      qty = qty_to_treat(city: city, color: color)
      gamestate.diseases[color].available += qty
      gamestate.cities[city].infections[color] -= qty
    end

    def treat_city_valid?(city:, color:)
      treat_actions.any? {|action| action.args[:city] = city && action.args[:color] = color}
    end

    def qty_to_treat(city:, color:)
      disease = gamestate.diseases[color]
      if disease.cured?
        gamestate.cities[city].infections[color]
      else
        1
      end
    end
  end

  class NothingToTreateException < Exception
  end
end

module Epidemic
  class MedicInCityBehavior < DefaultInCityBehavior
    def can_infect?(color)
      !gamestate.diseases[color].cured?
    end
  end
end

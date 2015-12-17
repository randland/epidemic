module Epidemic
  class MedicTreatBehavior < DefaultTreatBehavior
    private

    def qty_to_treat(city:, color:)
      disease = gamestate.diseases[color]
      gamestate.cities[city].infections[color]
    end
  end
end

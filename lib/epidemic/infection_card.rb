module Epidemic
  class InfectionCard < DataModel
    property :city,
      required: true,
      coerce: Symbol

    property :color,
      required: true,
      coerce: Symbol
  end
end

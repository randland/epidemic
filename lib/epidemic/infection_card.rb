module Epidemic
  class InfectionCard < DataModel
    property :city,
      coerce: Symbol,
      require: true
    property :color,
      coerce: Symbol
  end
end

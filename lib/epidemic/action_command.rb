module Epidemic
  class ActionCommand < DataModel
    property :behavior,
      coerce: ->(val) { coerce_class val }
    property :action,
      coerce: String
    property :args

    def execute(gamestate)
      execute!(gamestate.deep_clone)
    end

    def execute!(gamestate)
      cost = behavior.action_cost
      raise NoMoreActionsException unless cost == 0 || gamestate.remaining_actions > 0
      behavior.new(gamestate).send action, args
      gamestate.actions_used += cost
      gamestate
    end
  end

  class NoMoreActionsException < Exception
  end
end

module Epidemic
  class DefaultMoveBehavior < ActionBehavior
    def initialize(gamestate)
      self.gamestate = gamestate
      self.player = gamestate.current_player
    end

    def available_actions
      result = []
      result += drive_or_ferry_actions
      result += shuttle_actions
    end

    private

    def drive_or_ferry_actions
      @drive_or_ferry_actions ||=
        gamestate.cities_connected_to(player.location).collect do |tag, city|
          ActionCommand.new behavior: self.class,
            action: :drive_or_ferry,
            args: { to: tag.to_sym }
        end
    end

    def drive_or_ferry(to:)
      raise InvalidMoveException unless drive_or_ferry_valid? to: to
      player.move_to_location to
      player.enter_city_behavior.execute!(gamestate, player)
    end

    def drive_or_ferry_valid?(to:)
      drive_or_ferry_actions.collect {|action| action.args[:to]}.include? to
    end

    def shuttle_actions
      research_stations = gamestate.research_stations
      @shuttle_actions ||=
        if research_stations.include? player.location
          (research_stations - [player.location]).collect do |tag|
            ActionCommand.new behavior: self.class,
              action: :shuttle,
              args: { to: tag.to_sym }
          end
        else
          []
        end
    end

    def shuttle(to:)
      raise InvalidMoveException unless shuttle_valid? to: to
      player.move_to_location to
      player.enter_city_behavior.execute(gamestate, player)
    end

    def shuttle_valid?(to:)
      shuttle_actions.collect {|action| action.args[:to]}.include? to
    end
  end

  class InvalidMoveException < Exception
  end
end

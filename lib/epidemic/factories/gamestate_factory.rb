module Epidemic
  module Factories
    class GamestateFactory
      attr_accessor :gamestate

      def self.create_game(options={})
        new(options).gamestate
      end

      private

      def initialize(total_epidemics: 5, player_roles: [:default, :default, :default, :default], **options)
        params = options.merge total_epidemics: total_epidemics
        self.gamestate = Epidemic::Gamestate.new params
        add_players player_roles unless gamestate.players.any?
        populate_infection_deck
        perform_initial_infections
        populate_player_deck
        perform_initial_player_deal
        add_epidemics
        gamestate
      end

      def populate_infection_deck
        Epidemic::Services::PopulateInfectionDeckService.execute! gamestate
      end

      def populate_player_deck
        Epidemic::Services::PopulatePlayerDeckService.execute! gamestate
      end

      def perform_initial_infections
        Epidemic::Services::InitialInfectionService.execute! gamestate
      end

      def perform_initial_player_deal
        Epidemic::Services::InitialPlayerDealService.execute! gamestate
      end

      def add_players(player_roles)
        gamestate.players = player_roles.collect do |player_role|
          params = { role: player_role }
          case player_role
          when :generalist
            params.merge actions_per_turn: 5
          else
            params
          end
        end
      end

      def add_epidemics
        gamestate.player_deck = gamestate.player_deck.in_groups(gamestate.total_epidemics, false).collect do |pile|
          pile << { draw_behavior: Epidemic::EpidemicCardDrawBehavior }
          pile.shuffle
        end.flatten
      end
    end
  end
end


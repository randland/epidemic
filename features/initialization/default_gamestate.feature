Feature: Gamestate initialization
  In order to start a new game of Epidemic
  I should be able to instantiate a default game

  Scenario: Default game
    Given I have a new default gamestate
    Then the current gamestate should have the following diseases:
      | Color  | Available | Cured | Eradicated |
      | black  | 24        | false | false      |
      | blue   | 24        | false | false      |
      | red    | 24        | false | false      |
      | yellow | 24        | false | false      |

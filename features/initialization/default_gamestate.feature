Feature: Gamestate initialization
  In order to start a new game of Epidemic
  I should be able to instantiate a default game

  Scenario: Default game
    Given I have a new default gamestate
    Then the current gamestate should have the following diseases:
      | Color  |
      | black  |
      | blue   |
      | red    |
      | yellow |

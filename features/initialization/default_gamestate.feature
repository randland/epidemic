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
    And the current gamestate should have the following cities:
      | Tag              |
      | algiers          |
      | atlanta          |
      | baghdad          |
      | bangkok          |
      | bejing           |
      | bogota           |
      | buenos_aires     |
      | cairo            |
      | chennai          |
      | chicago          |
      | delhi            |
      | essen            |
      | ho_chi_minh_city |
      | hong_kong        |
      | istanbul         |
      | jakarta          |
      | johannesburg     |
      | karachi          |
      | khartoum         |
      | kinshasa         |
      | kolkata          |
      | lagos            |
      | lima             |
      | london           |
      | los_angeles      |
      | madrid           |
      | manila           |
      | mexico_city      |
      | miami            |
      | milan            |
      | montreal         |
      | moscow           |
      | mumbai           |
      | new_york         |
      | osaka            |
      | paris            |
      | riyadh           |
      | san_francisco    |
      | santiago         |
      | sao_paulo        |
      | seoul            |
      | shanghai         |
      | st_petersburg    |
      | sydney           |
      | taipei           |
      | tehran           |
      | tokyo            |
      | washington       |

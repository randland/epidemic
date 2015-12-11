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
      | Tag              | Color  |
      | algiers          | black  |
      | atlanta          | blue   |
      | baghdad          | black  |
      | bangkok          | red    |
      | bejing           | red    |
      | bogota           | yellow |
      | buenos_aires     | yellow |
      | cairo            | black  |
      | chennai          | black  |
      | chicago          | blue   |
      | delhi            | black  |
      | essen            | blue   |
      | ho_chi_minh_city | red    |
      | hong_kong        | red    |
      | istanbul         | black  |
      | jakarta          | red    |
      | johannesburg     | yellow |
      | karachi          | black  |
      | khartoum         | yellow |
      | kinshasa         | yellow |
      | kolkata          | black  |
      | lagos            | yellow |
      | lima             | yellow |
      | london           | blue   |
      | los_angeles      | yellow |
      | madrid           | blue   |
      | manila           | red    |
      | mexico_city      | yellow |
      | miami            | yellow |
      | milan            | blue   |
      | montreal         | blue   |
      | moscow           | black  |
      | mumbai           | black  |
      | new_york         | blue   |
      | osaka            | red    |
      | paris            | blue   |
      | riyadh           | black  |
      | san_francisco    | blue   |
      | santiago         | yellow |
      | sao_paulo        | yellow |
      | seoul            | red    |
      | shanghai         | red    |
      | st_petersburg    | blue   |
      | sydney           | red    |
      | taipei           | red    |
      | tehran           | black  |
      | tokyo            | red    |
      | washington       | blue   |

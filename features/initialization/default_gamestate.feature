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
      | Tag              | Color  | Name             |
      | algiers          | black  | Algiers          |
      | atlanta          | blue   | Atlanta          |
      | baghdad          | black  | Baghdad          |
      | bangkok          | red    | Bangkok          |
      | bejing           | red    | Bejing           |
      | bogota           | yellow | Bogota           |
      | buenos_aires     | yellow | Buenos Aires     |
      | cairo            | black  | Cairo            |
      | chennai          | black  | Chennai          |
      | chicago          | blue   | Chicago          |
      | delhi            | black  | Delhi            |
      | essen            | blue   | Essen            |
      | ho_chi_minh_city | red    | Ho Chi Minh City |
      | hong_kong        | red    | Hong Kong        |
      | istanbul         | black  | Istanbul         |
      | jakarta          | red    | Jakarta          |
      | johannesburg     | yellow | Johannesburg     |
      | karachi          | black  | Karachi          |
      | khartoum         | yellow | Khartoum         |
      | kinshasa         | yellow | Kinshasa         |
      | kolkata          | black  | Kolkata          |
      | lagos            | yellow | Lagos            |
      | lima             | yellow | Lima             |
      | london           | blue   | London           |
      | los_angeles      | yellow | Los Angeles      |
      | madrid           | blue   | Madrid           |
      | manila           | red    | Manila           |
      | mexico_city      | yellow | Mexico City      |
      | miami            | yellow | Miami            |
      | milan            | blue   | Milan            |
      | montreal         | blue   | Montreal         |
      | moscow           | black  | Moscow           |
      | mumbai           | black  | Mumbai           |
      | new_york         | blue   | New York         |
      | osaka            | red    | Osaka            |
      | paris            | blue   | Paris            |
      | riyadh           | black  | Riyadh           |
      | san_francisco    | blue   | San Francisco    |
      | santiago         | yellow | Santiago         |
      | sao_paulo        | yellow | Sao Paulo        |
      | seoul            | red    | Seoul            |
      | shanghai         | red    | Shanghai         |
      | st_petersburg    | blue   | St Petersburg    |
      | sydney           | red    | Sydney           |
      | taipei           | red    | Taipei           |
      | tehran           | black  | Tehran           |
      | tokyo            | red    | Tokyo            |
      | washington       | blue   | Washington       |
    And the current gamestate should have the following cities connected:
      | algiers          | cairo            |
      | algiers          | istanbul         |
      | algiers          | madrid           |
      | algiers          | paris            |
      | atlanta          | chicago          |
      | atlanta          | miami            |
      | atlanta          | washington       |
      | baghdad          | cairo            |
      | baghdad          | istanbul         |
      | baghdad          | karachi          |
      | baghdad          | riyadh           |
      | baghdad          | tehran           |
      | bangkok          | chennai          |
      | bangkok          | ho_chi_minh_city |
      | bangkok          | hong_kong        |
      | bangkok          | jakarta          |
      | bangkok          | kolkata          |
      | bejing           | seoul            |
      | bejing           | shanghai         |
      | bogota           | buenos_aires     |
      | bogota           | lima             |
      | bogota           | mexico_city      |
      | bogota           | miami            |
      | bogota           | sao_paulo        |
      | buenos_aires     | sao_paulo        |
      | cairo            | istanbul         |
      | cairo            | khartoum         |
      | cairo            | riyadh           |
      | chennai          | delhi            |
      | chennai          | jakarta          |
      | chennai          | kolkata          |
      | chennai          | mumbai           |
      | chicago          | los_angeles      |
      | chicago          | mexico_city      |
      | chicago          | montreal         |
      | chicago          | san_francisco    |
      | delhi            | karachi          |
      | delhi            | kolkata          |
      | delhi            | mumbai           |
      | delhi            | tehran           |
      | essen            | london           |
      | essen            | milan            |
      | essen            | paris            |
      | essen            | st_petersburg    |
      | ho_chi_minh_city | hong_kong        |
      | ho_chi_minh_city | jakarta          |
      | ho_chi_minh_city | manila           |
      | hong_kong        | kolkata          |
      | hong_kong        | manila           |
      | hong_kong        | taipei           |
      | istanbul         | milan            |
      | istanbul         | moscow           |
      | istanbul         | st_petersburg    |
      | jakarta          | sydney           |
      | johannesburg     | khartoum         |
      | johannesburg     | kinshasa         |
      | karachi          | mumbai           |
      | karachi          | riyadh           |
      | karachi          | tehran           |
      | khartoum         | kinshasa         |
      | khartoum         | lagos            |
      | kinshasa         | lagos            |
      | lagos            | sao_paulo        |
      | lima             | mexico_city      |
      | lima             | santiago         |
      | london           | madrid           |
      | london           | new_york         |
      | london           | paris            |
      | los_angeles      | mexico_city      |
      | los_angeles      | san_francisco    |
      | los_angeles      | sydney           |
      | madrid           | new_york         |
      | madrid           | paris            |
      | madrid           | sao_paulo        |
      | manila           | san_francisco    |
      | manila           | sydney           |
      | manila           | taipei           |
      | mexico_city      | miami            |
      | miami            | washington       |
      | milan            | paris            |
      | montreal         | new_york         |
      | montreal         | washington       |
      | moscow           | st_petersburg    |
      | moscow           | tehran           |
      | new_york         | washington       |
      | osaka            | taipei           |
      | osaka            | tokyo            |
      | san_francisco    | tokyo            |
      | seoul            | shanghai         |
      | seoul            | tokyo            |
      | shanghai         | taipei           |
      | shanghai         | tokyo            |

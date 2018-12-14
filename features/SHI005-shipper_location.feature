Feature: Shipper Location
  Able to access the list of Locations
  As a Administrator
  Be able to add, edit, delete locations

  Background:
    Given I login as administrator
    Then there should be an success message "Scout Admin"
    Then go to the "Shippers" page
    When I go to the new shipper page
    And add a "shipper" with these data
      | sales_priority | company_name  | shipper_type  | loads_per_month | spend_per_year  | blue_book_score  | blue_book_url      | buying_criteria | price_sensitivity | years_in_business |
      | A              | test1234      | Broker        | 11-50           | 1M-5M           | 0                | http://sample.com  | Price           | Above Market      | 1                 |
    Then submit the form
    And the shipper "test1234" should be on the show page
    Then click the "location" tab

  Scenario: Create a New Location
    Then click the new "location" button
    And add a "shipper_location" with these data
      | address | city    | postal  | phone       |
      | Sample  | Sample  | A2A2A2  | 2121211212  |
    Then submit the form
    Then click the "location" tab
    Then there should have "Sample" on the table

  Scenario: Edit a Location
    Then click the new "location" button
    And add a "shipper_location" with these data
      | address | city    | postal  | phone       |
      | Sample  | Sample  | A2A2A2  | 2121211212  |
    Then submit the form
    And the shipper "test1234" should be on the show page
    Then click the "location" tab
    Then there should have "Sample" on the table
    When I click the first edit button on the "location" table
    And edit the "shipper_location" with these data
      | address  | city      |
      | Sample2  | Sample2  |
    Then submit the form
    Then click the "location" tab
    Then there should have "Sample2" on the table

  Scenario: Delete a Location
    Then click the new "location" button
    And add a "shipper_location" with these data
      | address | city    | postal  | phone       |
      | Sample  | Sample  | A2A2A2  | 2121211212  |
    Then submit the form
    Then click the "location" tab
    Then there should have "Sample" on the table
    When I click the first delete button on the "location" table
    Then click the "location" tab

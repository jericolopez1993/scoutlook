Feature: Carrier Location
  Able to access the list of Locations
  As a Administrator
  Be able to add, edit, delete locations

  Background:
  Given I login as administrator
  Then there should be an success message "Scout Admin"
  Then go to the "Carriers" page
  When I go to the new carrier page
  And add a "carrier" with these data
    | sales_priority | company_name  | score_card  | freight_guard | years_in_business | power_units | company_drivers | owner_operators | reefers | dry_vans  | flat_beds | teams | contract_rates  | total_fleet_size  |
    | A              | test1234      | 0           | 0             | 0                 | 0           | 0               | 0               | 0       | 0         | 0         | 0     | 25-50           | 26-50             |
  Then submit the form
  And the carrier "test1234" should be on the show page
  Then click the "location" tab

  Scenario: Create a New Location
    Then click the new "location" button
    And add a "carrier_location" with these data
      | address | city    | postal  | phone       |
      | Sample  | Sample  | A2A2A2  | 2121211212  |
    Then submit the form
    Then click the "location" tab
    Then there should have "Sample" on the table

  Scenario: Edit a Location
    Then click the new "location" button
    And add a "carrier_location" with these data
      | address | city    | postal  | phone       |
      | Sample  | Sample  | A2A2A2  | 2121211212  |
    Then submit the form
    And the carrier "test1234" should be on the show page
    Then click the "location" tab
    Then there should have "Sample" on the table
    When I click the first edit button on the "location" table
    And edit the "carrier_location" with these data
      | address  | city      |
      | Sample2  | Sample2  |
    Then submit the form
    Then click the "location" tab
    Then there should have "Sample2" on the table

  Scenario: Delete a Location
    Then click the new "location" button
    And add a "carrier_location" with these data
      | address | city    | postal  | phone       |
      | Sample  | Sample  | A2A2A2  | 2121211212  |
    Then submit the form
    Then click the "location" tab
    Then there should have "Sample" on the table
    When I click the first delete button on the "location" table
    Then click the "location" tab

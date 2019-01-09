Feature: Carrier Lane
  Able to access the list of Lanes
  As a Administrator
  Be able to add, edit, delete lanes

  Background:
  Given I login as administrator
  Then there should be an success message "Scout Admin"
  Then go to the "Carriers" page
  When I go to the new carrier page
  And add a "carrier" with these data
    | sales_priority | company_name  | score_card  | freight_guard | years_in_business | power_units | company_drivers | owner_operators | reefers | dry_vans  | flat_beds | teams | total_fleet_size  |
    | A              | test1234      | 0           | 0             | 0                 | 0           | 0               | 0               | 0       | 0         | 0         | 0     | 26-50             |
  Then submit the form
  And the carrier "test1234" should be on the show page
  Then click the "lane" tab

  Scenario: Create a New Lane
    Then click the new "lane" button
    And add a "carrier_lane" with these data
      | lane_priority | truck_per_week |
      | High          | 2              |
    Then submit the form
    Then click the "lane" tab
    Then there should have "High" on the table

  Scenario: Edit a Lane
    Then click the new "lane" button
    And add a "carrier_lane" with these data
      | lane_priority | truck_per_week |
      | High          | 2              |
    Then submit the form
    And the carrier "test1234" should be on the show page
    Then click the "lane" tab
    Then there should have "High" on the table
    When I click the first edit button on the "lane" table
    And edit the "carrier_lane" with these data
      | lane_priority | truck_per_week |
      | Low           | 2              |
    Then submit the form
    Then click the "lane" tab
    Then there should have "Low" on the table

  Scenario: Delete a Lane
    Then click the new "lane" button
    And add a "carrier_lane" with these data
      | lane_priority | truck_per_week |
      | High          | 2              |
    Then submit the form
    Then click the "lane" tab
    Then there should have "High" on the table
    When I click the first delete button on the "lane" table
    Then click the "lane" tab

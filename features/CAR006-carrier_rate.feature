Feature: Carrier Rate
  Able to access the list of Rates
  As a Administrator
  Be able to add, edit, delete rates

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
  Then click the "rate" tab

  Scenario: Create a New Rate
    Then click the new "rate" button
    And add a "carrier_rate" with these data
      | rate_level | rate_type  | freight_desc  | freight_classification  | transit_time  | minimum_density |
      | Master     | Contract   | Sample        | Sample2                 | 180           | 60              |
    Then submit the form
    Then click the "rate" tab
    Then there should have "Master" on the table

  Scenario: Edit a Rate
    Then click the new "rate" button
    And add a "carrier_rate" with these data
      | rate_level | rate_type  | freight_desc  | freight_classification  | transit_time  | minimum_density |
      | Master     | Contract   | Sample        | Sample2                 | 180           | 60              |
    Then submit the form
    And the carrier "test1234" should be on the show page
    Then click the "rate" tab
    Then there should have "Master" on the table
    When I click the first edit button on the "rate" table
    And edit the "carrier_rate" with these data
      | rate_level | rate_type  |
      | Child      | Proposal   |
    Then submit the form
    Then click the "rate" tab
    Then there should have "Child" on the table

  Scenario: Delete a Rate
    Then click the new "rate" button
    And add a "carrier_rate" with these data
      | rate_level | rate_type  | freight_desc  | freight_classification  | transit_time  | minimum_density |
      | Master     | Contract   | Sample        | Sample2                 | 180           | 60              |
    Then submit the form
    Then click the "rate" tab
    Then there should have "Master" on the table
    When I click the first delete button on the "rate" table
    Then click the "rate" tab

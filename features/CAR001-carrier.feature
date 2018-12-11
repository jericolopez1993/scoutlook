Feature: Carriers
  Able to access the list of Carriers
  As a Administrator
  Be able to add, edit, delete carriers

  Background:
    Given I login as administrator
    Then there should be an success message "Scout Admin"

  Scenario: List of Carriers
    And there should be these items on my menu
      | Carriers  |
      | Shippers  |
      | Stewards  |
    Then go to the "Carriers" page
    And there should be "Carriers" header title

  Scenario: Create a New Carrier
    Then go to the "Carriers" page
    When I go to the new carrier page
    And add a carrier with these data
      | sales_priority | company_name  | score_card  | freight_guard | years_in_business | power_units | company_drivers | owner_operators | reefers | dry_vans  | flat_beds | teams | contract_rates  | total_fleet_size  |
      | A              | test1234      | 0           | 0             | 0                 | 0           | 0               | 0               | 0       | 0         | 0         | 0     | 25-50           | 26-50             |
    Then submit the form
    And the carrier "test1234" should be on the show page

  Scenario: Edit a Carrier
    Then go to the "Carriers" page
    When I go to the new carrier page
    And add a carrier with these data
      | sales_priority | company_name  | score_card  | freight_guard | years_in_business | power_units | company_drivers | owner_operators | reefers | dry_vans  | flat_beds | teams | contract_rates  | total_fleet_size  |
      | A              | test1234      | 0           | 0             | 0                 | 0           | 0               | 0               | 0       | 0         | 0         | 0     | 25-50           | 26-50             |
    Then submit the form
    And the carrier "test1234" should be on the show page
    When I clicked the edit button
    And edit the carrier with these data
      | sales_priority |  company_name |
      | B              |  testedit1234 |
    Then submit the form
    And the carrier "testedit1234" should be on the show page

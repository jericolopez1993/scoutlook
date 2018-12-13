Feature: Carrier Activities
  Able to access the list of Carriers
  As a Administrator
  Be able to add, edit, delete carriers

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
    Then click the "activity" tab

  Scenario: Create a New Activity
    Then click the new "activity" button
    And add a "carrier_activity" with these data
      | engagement_type | rep_id        | annual_value |
      | Engagement      | Kevin Marcelo | 5-10M        |
    Then submit the form
    Then click the "activity" tab
    Then there should have "Engagement" on the table

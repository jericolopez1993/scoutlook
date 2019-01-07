Feature: Carrier Activities
  Able to access the list of Activity
  As a Administrator
  Be able to add, edit, delete activities

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

  Scenario: Edit a Activity
    Then click the new "activity" button
    And add a "carrier_activity" with these data
      | engagement_type | rep_id        | annual_value |
      | Engagement      | Kevin Marcelo | 5-10M        |
    Then submit the form
    And the carrier "test1234" should be on the show page
    Then click the "activity" tab
    Then there should have "Engagement" on the table
    When I click the first edit button on the "engagement" table
    And edit the "carrier_activity" with these data
      | engagement_type |  annual_value |
      | Proposal            |  10-25M       |
    Then submit the form
    Then click the "activity" tab
    Then there should have "Proposal" on the table

  Scenario: Delete a Activity
    Then click the new "activity" button
    And add a "carrier_activity" with these data
      | engagement_type | rep_id        | annual_value |
      | Engagement      | Kevin Marcelo | 5-10M        |
    Then submit the form
    Then click the "activity" tab
    Then there should have "Engagement" on the table
    When I click the first delete button on the "engagement" table
    Then click the "activity" tab

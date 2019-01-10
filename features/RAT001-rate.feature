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
    | sales_priority | company_name  | score_card  | freight_guard | years_in_business | power_units | company_drivers | owner_operators | reefers | dry_vans  | flat_beds | teams | total_fleet_size  |
    | A              | test1234      | 0           | 0             | 0                 | 0           | 0               | 0               | 0       | 0         | 0         | 0     | 26-50             |
  Then submit the form
  And the carrier "test1234" should be on the show page
  Then click the "activity" tab
  Then click the new "activity" button
  And add a "activity" with these data
    | engagement_type | annual_value |
    | Proposal        | 5-10M        |
  Then submit the form
  Then click the "activity" tab
  Then there should have "Proposal" on the table
  When I click the first show button on the "activities" table

  Scenario: Create a New Rate
    Then click the new "rate" button
    And add a "rate" with these data
      | picks | drops  | bid  | ask  | cost  | mc_number |
      | 1     | 1      | 123  | 150  | 150   | 17845     |
    Then submit the form
    Then there should have "123" on the table

  Scenario: Edit a Rate
    Then click the new "rate" button
    And add a "rate" with these data
      | picks | drops  | bid  | ask  | cost  | mc_number |
      | 1     | 1      | 123  | 150  | 150   | 17845     |
    Then submit the form
    And the carrier "test1234" should be on the show page
    Then there should have "123" on the table
    When I click the first edit button on the "rates" table
    And edit the "rate" with these data
      | bid  | ask  | cost  | mc_number |
      | 133  | 130  | 150   | 17845     |
    Then submit the form
    Then there should have "133" on the table

  Scenario: Delete a Rate
    Then click the new "rate" button
    And add a "rate" with these data
      | picks | drops  | bid  | ask  | cost  | mc_number |
      | 1     | 1      | 123  | 150  | 150   | 17845     |
    Then submit the form
    Then click the "rate" tab
    Then there should have "123" on the table
    When I click the first delete button on the "rates" table

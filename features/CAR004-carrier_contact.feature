Feature: Carrier Contact
  Able to access the list of Contacts
  As a Administrator
  Be able to add, edit, delete contacts

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
  Then click the "contact" tab

  Scenario: Create a New Contact
    Then click the new "contact" button
    And add a "carrier_contact" with these data
      | contact_type | first_name | last_name | title   | email             | password  | password_confirmation |
      | Owner        | ftest      | ltest     | Tester  | tester@ltest.com  | password  | password              |
    Then submit the form
    Then click the "contact" tab
    Then there should have "ftest ltest" on the table

  Scenario: Edit a Contact
    Then click the new "contact" button
    And add a "carrier_contact" with these data
      | contact_type | first_name | last_name | title   | email             | password  | password_confirmation |
      | Owner        | ftest      | ltest     | Tester  | tester@ltest.com  | password  | password              |
    Then submit the form
    And the carrier "test1234" should be on the show page
    Then click the "contact" tab
    Then there should have "ftest ltest" on the table
    When I click the first edit button on the "contact" table
    And edit the "carrier_contact" with these data
      | contact_type | first_name | last_name | title   | password  |
      | Sales        | fltest     | lftest    | Tester  | password  |
    Then submit the form
    Then click the "contact" tab
    Then there should have "fltest lftest" on the table

  Scenario: Delete a Contact
    Then click the new "contact" button
    And add a "carrier_contact" with these data
      | contact_type | first_name | last_name | title   | email             | password  | password_confirmation |
      | Owner        | ftest      | ltest     | Tester  | tester@ltest.com  | password  | password              |
    Then submit the form
    Then click the "contact" tab
    Then there should have "ftest ltest" on the table
    When I click the first delete button on the "contact" table
    Then click the "contact" tab

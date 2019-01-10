Feature: Shipper Contact
  Able to access the list of Contacts
  As a Administrator
  Be able to add, edit, delete contacts

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
    Then click the "contact" tab

  Scenario: Create a New Contact
    Then click the new "contact" button
    And add a "shipper_contact" with these data
      | contact_type | first_name | last_name | title   | email             |
      | Owner        | ftest      | ltest     | Tester  | tester@ltest.com  |
    Then submit the form
    Then click the "contact" tab
    Then there should have "ftest ltest" on the table

  Scenario: Edit a Contact
    Then click the new "contact" button
    And add a "shipper_contact" with these data
      | contact_type | first_name | last_name | title   | email             |
      | Owner        | ftest      | ltest     | Tester  | tester@ltest.com  |
    Then submit the form
    And the shipper "test1234" should be on the show page
    Then click the "contact" tab
    Then there should have "ftest ltest" on the table
    When I click the first edit button on the "contact" table
    And edit the "shipper_contact" with these data
      | contact_type | first_name | last_name | title   |
      | Sales        | fltest     | lftest    | Tester  |
    Then submit the form
    Then click the "contact" tab
    Then there should have "fltest lftest" on the table

  Scenario: Delete a Contact
    Then click the new "contact" button
    And add a "shipper_contact" with these data
      | contact_type | first_name | last_name | title   | email             |
      | Owner        | ftest      | ltest     | Tester  | tester@ltest.com  |
    Then submit the form
    Then click the "contact" tab
    Then there should have "ftest ltest" on the table
    When I click the first delete button on the "contact" table
    Then click the "contact" tab

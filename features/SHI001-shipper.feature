Feature: Shippers
  Able to access the list of Shippers
  As a Administrator
  Be able to add, edit, delete shippers

  Background:
    Given I login as administrator
    Then there should be an success message "Scout Admin"

  Scenario: List of Shippers
    And there should be these items on my menu
      | Shippers  |
      | Shippers  |
      | Stewards  |
    Then go to the "Shippers" page
    And there should be "Shippers" header title

  Scenario: Create a New Shipper
    Then go to the "Shippers" page
    When I go to the new shipper page
    And add a "shipper" with these data
      | sales_priority | company_name  | shipper_type  | loads_per_month | spend_per_year  | blue_book_score  | blue_book_url      | buying_criteria | price_sensitivity | years_in_business |
      | A              | test1234      | Broker        | 11-50           | 1M-5M           | 0                | http://sample.com  | Price           | Above Market      | 1                 |
    Then submit the form
    And the shipper "test1234" should be on the show page

  Scenario: Edit a Shipper
    Then go to the "Shippers" page
    When I go to the new shipper page
    And add a "shipper" with these data
      | sales_priority | company_name  | shipper_type  | loads_per_month | spend_per_year  | blue_book_score  | blue_book_url      | buying_criteria | price_sensitivity | years_in_business |
      | A              | test1234      | Broker        | 11-50           | 1M-5M           | 0                | http://sample.com  | Price           | Above Market      | 1                 |
    Then submit the form
    And the shipper "test1234" should be on the show page
    When I clicked the edit button
    And edit the "shipper" with these data
      | sales_priority |  company_name |
      | B              |  testedit1234 |
    Then submit the form
    And the shipper "testedit1234" should be on the show page

  Scenario: Delete a Shipper
    Then go to the "Shippers" page
    When I go to the new shipper page
    And add a "shipper" with these data
      | sales_priority | company_name  | shipper_type  | loads_per_month | spend_per_year  | blue_book_score  | blue_book_url      | buying_criteria | price_sensitivity | years_in_business |
      | A              | test1234      | Broker        | 11-50           | 1M-5M           | 0                | http://sample.com  | Price           | Above Market      | 1                 |
    Then submit the form
    And the shipper "test1234" should be on the show page
    When I clicked the delete button
    Then there should not have "test1234" on the table

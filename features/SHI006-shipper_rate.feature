Feature: Shipper Rate
  Able to access the list of Rates
  As a Administrator
  Be able to add, edit, delete rates

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
    Then click the "rate" tab

  Scenario: Create a New Rate
    Then click the new "rate" button
    And add a "shipper_rate" with these data
      | rate_level | rate_type  | freight_desc  | freight_classification  | transit_time  | minimum_density |
      | Master     | Contract   | Sample        | Sample2                 | 180           | 60              |
    Then submit the form
    Then click the "rate" tab
    Then there should have "Master" on the table

  Scenario: Edit a Rate
    Then click the new "rate" button
    And add a "shipper_rate" with these data
      | rate_level | rate_type  | freight_desc  | freight_classification  | transit_time  | minimum_density |
      | Master     | Contract   | Sample        | Sample2                 | 180           | 60              |
    Then submit the form
    And the shipper "test1234" should be on the show page
    Then click the "rate" tab
    Then there should have "Master" on the table
    When I click the first edit button on the "rate" table
    And edit the "shipper_rate" with these data
      | rate_level | rate_type  |
      | Child      | Proposal   |
    Then submit the form
    Then click the "rate" tab
    Then there should have "Child" on the table

  Scenario: Delete a Rate
    Then click the new "rate" button
    And add a "shipper_rate" with these data
      | rate_level | rate_type  | freight_desc  | freight_classification  | transit_time  | minimum_density |
      | Master     | Contract   | Sample        | Sample2                 | 180           | 60              |
    Then submit the form
    Then click the "rate" tab
    Then there should have "Master" on the table
    When I click the first delete button on the "rate" table
    Then click the "rate" tab

Feature: Shipper Lane
  Able to access the list of Lanes
  As a Administrator
  Be able to add, edit, delete lanes

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
    Then click the "lane" tab

  Scenario: Create a New Lane
    Then click the new "lane" button
    And add a "shipper_lane" with these data
      | lane_priority | truck_per_week |
      | High          | 2              |
    Then submit the form
    Then click the "lane" tab
    Then there should have "High" on the table

  Scenario: Edit a Lane
    Then click the new "lane" button
    And add a "shipper_lane" with these data
      | lane_priority | truck_per_week |
      | High          | 2              |
    Then submit the form
    And the shipper "test1234" should be on the show page
    Then click the "lane" tab
    Then there should have "High" on the table
    When I click the first edit button on the "lane" table
    And edit the "shipper_lane" with these data
      | lane_priority | truck_per_week |
      | Low           | 2              |
    Then submit the form
    Then click the "lane" tab
    Then there should have "Low" on the table

  Scenario: Delete a Lane
    Then click the new "lane" button
    And add a "shipper_lane" with these data
      | lane_priority | truck_per_week |
      | High          | 2              |
    Then submit the form
    Then click the "lane" tab
    Then there should have "High" on the table
    When I click the first delete button on the "lane" table
    Then click the "lane" tab

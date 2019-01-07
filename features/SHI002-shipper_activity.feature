Feature: Shipper Activities
  Able to access the list of Activity
  As a Administrator
  Be able to add, edit, delete activities

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
    Then click the "activity" tab

  Scenario: Create a New Activity
    Then click the new "activity" button
    And add a "shipper_activity" with these data
      | engagement_type | rep_id        | annual_value |
      | Engagement      | Kevin Marcelo | 5-10M        |
    Then submit the form
    Then click the "activity" tab
    Then there should have "Engagement" on the table

  Scenario: Edit a Activity
    Then click the new "activity" button
    And add a "shipper_activity" with these data
      | engagement_type | rep_id        | annual_value |
      | Engagement      | Kevin Marcelo | 5-10M        |
    Then submit the form
    And the shipper "test1234" should be on the show page
    Then click the "activity" tab
    Then there should have "Engagement" on the table
    When I click the first edit button on the "engagement" table
    And edit the "shipper_activity" with these data
      | engagement_type |  annual_value |
      | Proposal            |  10-25M       |
    Then submit the form
    Then click the "activity" tab
    Then there should have "Proposal" on the table

  Scenario: Delete a Activity
    Then click the new "activity" button
    And add a "shipper_activity" with these data
      | engagement_type | rep_id        | annual_value |
      | Engagement      | Kevin Marcelo | 5-10M        |
    Then submit the form
    Then click the "activity" tab
    Then there should have "Engagement" on the table
    When I click the first delete button on the "engagement" table
    Then click the "activity" tab

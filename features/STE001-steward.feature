Feature: Stewards
  Able to access the list of Stewards
  As a Administrator
  Be able to add, edit, delete stewards

  Background:
    Given I login as administrator
    Then there should be an success message "Scout Admin"

  Scenario: List of Stewards
    And there should be these items on my menu
      | Carriers  |
      | Shippers  |
      | Stewards  |
    Then go to the "Stewards" page

  Scenario: Create a New Steward
    Then go to the "Stewards" page
    When I go to the new steward page
    And add a "steward" with these data
      | first_name |  last_name  |  date_of_hire  | phone       | email                   | password  | password_confirmation |
      | test       |  sample     |  12/12/2018    | 2122222222  | test@sample80@gmail.com | password  | password              |
    Then submit the form
    And the steward "test sample" should be on the show page

  Scenario: Edit a Steward
    Then go to the "Stewards" page
    When I go to the new steward page
    And add a "steward" with these data
      | first_name |  last_name  |  date_of_hire  | phone       | email                   | password  | password_confirmation |
      | test       |  sample     |  12/12/2018    | 2122222222  | test@sample80@gmail.com | password  | password              |
    Then submit the form
    And the steward "test sample" should be on the show page
    When I clicked the edit button
    And edit the "steward" with these data
      | first_name  |  last_name   |  password  |
      | tests       |  samples     |  password  |
    Then submit the form
    And the steward "tests samples" should be on the show page

  Scenario: Delete a Steward
    Then go to the "Stewards" page
    When I go to the new steward page
    And add a "steward" with these data
      | first_name |  last_name  |  date_of_hire  | phone       | email                   | password  | password_confirmation |
      | test       |  sample     |  12/12/2018    | 2122222222  | test@sample80@gmail.com | password  | password              |
    Then submit the form
    And the steward "test sample" should be on the show page
    When I clicked the delete button
    Then there should not have "test sample" on the table

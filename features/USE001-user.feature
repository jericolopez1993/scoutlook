Feature: Users
  Login as different users

  Scenario: Login as Administrator
  	When I am on the login page
    And there should be a login content
    Then I should be able to login as admin
    And there should be these items on my menu
      | Carriers  |
      | Shippers  |
      | Stewards  |

  Scenario: Login with invalid credentials
    When I am on the login page
    And there should be a login content
    And login with email "admin@test.com" and password "password0987"
    Then there should be an invalid message "Invalid Email or password."

  Scenario: User doesn't exist
    When I am on the login page
    And there should be a login content
    And login with email "test123@test.com" and password "password0987"
    Then there should be an invalid message "Invalid Email or password."

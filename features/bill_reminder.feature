Feature: Bill Reminder

  Scenario: Validate POST bill_reminder API with valid parameters
    Given user id and login token
    When I make POST bill_reminder API call
    Then It should return success for bill_reminder
    When I make GET request to bill_reminder details
    Then It should have title bill reminder
    
  Scenario: Validate POST API with invalid login token
    Given user id and invalid login token
    When I make POST bill_reminders API call with wrong login token
    Then It should return bill_reminders invalid user-session-token message

  Scenario: Validate GET API with invalid login token
    Given invalid user id and login token
    When I make GET bill_reminders API call with wrong user-id
    Then It should return GET bill_reminders invalid user-id message
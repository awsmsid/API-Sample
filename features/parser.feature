Feature: Parser Endpoint

  Scenario: Validate POST API with valid parameters
    Given user id and login token for parser
    When I make parser API call
    Then It should return success
    And I send a GET request to receipt details
    Then the json response should have main receipt status complete
    And I send a GET request to reward_services
    Then It should return game-token 1

  Scenario: Validate POST API with invalid login token
    Given user id and invalid login token for parser
    When I make API call with wrong login token
    Then It should return invalid user-session-token message

  Scenario: Validate POST API with invalid user id
    Given invalid user id and login token for parser
    When I make API call with wrong user-id
    Then It should return invalid user-id message

  Scenario: Validate POST API with invalid receipt
    Given user id and login token for parser
    When I make parser API call with invalid receipt
    Then It should return success with invalid receipt
    And I send a GET request to receipt details with invalid receipt
    Then response should have main receipt status manual_processing with invalid receipt
    And I send a GET request to reward_services with invalid receipt
    Then It should return game-token 0 with invalid receipt

  Scenario: Validate POST API multiple receipts with valid parameters
    Given user id and login token for parser
    When I make parser API call with multiple receipts
    Then It should return success for multiple receipts
    And I send a GET request to receipt details for multiple receipts
    Then the json response should have main receipt status complete for multiple receipts
    And I send a GET request to reward_services for multiple receipts
    Then It should return game-token 1 for multiple receipts

  Scenario: Validate POST API with invalid login token for multiple receipts
    Given user id and invalid login token for parser
    When I make API call with wrong login token for multiple receipts
    Then It should return invalid user-session-token message for multiple receipts

  Scenario: Validate POST API with invalid user id for multiple receipts
    Given invalid user id and login token for parser
    When I make API call with wrong user-id for multiple receipts
    Then It should return invalid user-id message for multiple receipts

  Scenario: Validate POST API multiple receipts with invalid receipts
    Given user id and login token for parser
    When I make parser API call with invalid receipt for multiple receipts
    Then It should return success for multiple receipts with invalid receipts
    And I send a GET request to receipt details for multiple receipts with invalid receipts
    Then response should have main receipt status manual_processing for multiple receipts
    And I send a GET request to reward_services for multiple receipts with invalid receipts
    Then It should return game-token 0 for multiple receipts with invalid receipts
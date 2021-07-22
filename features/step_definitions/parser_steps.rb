# frozen_string_literal: true

# rubocop:disable MixinUsage
include WebMock::API
# rubocop:enable MixinUsage

def single_valid_receipt_1
  fixture_file_upload('wool_worths receipt jpg - WA.jpg', 'image/jpg')
end

def multi_valid_receipt_1
  fixture_file_upload('wool_worths_receipt1.jpeg', 'image/jpeg')
end

def multi_valid_receipt_2
  fixture_file_upload('wool_worths_receipt2.jpeg', 'image/jpeg')
end

def invalid_receipt_1
  fixture_file_upload('invalid_receipt1.jpg', 'image/jpeg')
end

def invalid_receipt_2
  fixture_file_upload('IGA_beckenham_receipt_2.jpeg', 'image/jpeg')
end

Given(/^user id and login token for parser$/) do
  @login_token = '_ZI7ogwaViko1_Q6edPzLg'
  @user_id = User.create!(id: 461,
                          email: 'test@gmail.com',
                          password: 'password',
                          password_confirmation: 'password').id
  RewardService.create(game_token: 0, credit_money: 0, user_id: @user_id)
end

Given(/^user id and invalid login token for parser$/) do
  @login_token = 'abc'
  @user_id = '461'
end

Given(/^invalid user id and login token for parser$/) do
  @login_token = '_ZI7ogwaViko1_Q6edPzLg'
  @user_id = 0
end

When(/^I make parser API call$/) do
  @url = 'http://mivi-api-staging.herokuapp.com/api/parser'
  @params = {
    picture: single_valid_receipt_1
  }
end

Then(/^It should return success$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = post @url, @params
  response_body = JSON response.body
  @id = response_body['data']['id']
  expect(response.status).to eq(200)
end

When(/^I send a GET request to receipt details$/) do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
  ReceiptProcessingInteractor.process_receipt(@id)
end

Then(/^the json response should have main receipt status complete$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  @id = response_body['data']['id']
  expect(response_body['data']['attributes']['status']).to eq('complete')
end

When('I send a GET request to reward_services') do
  @url = 'http://mivi-api-staging.herokuapp.com/api/reward_services'
end

Then('It should return game-token {int}') do |int|
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  game_token = response_body['data']['attributes']['game-token']
  expect(game_token).to eq(int)
end

# single invalid
When(/^I make parser API call with invalid receipt$/) do
  @url = 'http://mivi-api-staging.herokuapp.com/api/parser'
  @params = {
    picture: invalid_receipt_1
  }
end

Then(/^It should return success with invalid receipt$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = post @url, @params
  response_body = JSON response.body
  @id = response_body['data']['id']
  expect(response.status).to eq(200)
end

When(/^I send a GET request to receipt details with invalid receipt$/) do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
  ReceiptProcessingInteractor.process_receipt(@id)
end

Then(/^response should have main receipt status manual_processing with invalid receipt$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  @id = response_body['data']['id']
  expect(response_body['data']['attributes']['status']).to eq('manual_processing')
end

When('I send a GET request to reward_services with invalid receipt') do
  @url = 'http://mivi-api-staging.herokuapp.com/api/reward_services'
end

Then('It should return game-token {int} with invalid receipt') do |int|
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  game_token = response_body['data']['attributes']['game-token']
  expect(game_token).to eq(int)
end

When('I make API call with wrong login token') do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
end

Then('It should return invalid user-session-token message') do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  expect(response_body).to eq('error' => 'Invalid token.')
end

When('I make API call with wrong user-id') do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
  @user_id = '1'
  @login_token = '_ZI7ogwaViko1_Q6edPzLg'
end

Then('It should return invalid user-id message') do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  expect(response_body).to eq('error' => 'Invalid user id/application id.')
end

When(/^I make parser API call with multiple receipts$/) do
  @url = 'http://mivi-api-staging.herokuapp.com/api/parser'
  @params = {
    picture: [multi_valid_receipt_1, multi_valid_receipt_2]
  }
  RewardService.create(game_token: 0, credit_money: 0, user_id: @user_id)
end

Then(/^It should return success for multiple receipts$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = post @url, @params
  response_body = JSON response.body
  @id = response_body['data']['id']
  expect(response.status).to eq(200)
end

When(/^I send a GET request to receipt details for multiple receipts$/) do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
  ReceiptProcessingInteractor.process_receipt(@id)
end

Then(/^the json response should have main receipt status complete for multiple receipts$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  expect(response_body['data']['attributes']['status']).to eq('complete')
end

When('I send a GET request to reward_services for multiple receipts') do
  @url = 'http://mivi-api-staging.herokuapp.com/api/reward_services'
end

Then('It should return game-token {int} for multiple receipts') do |int|
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  game_token = response_body['data']['attributes']['game-token']
  expect(game_token).to eq(int)
end

When('I make API call with wrong login token for multiple receipts') do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
end

Then('It should return invalid user-session-token message for multiple receipts') do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  expect(response_body).to eq('error' => 'Invalid token.')
end

When('I make API call with wrong user-id for multiple receipts') do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
  @user_id = '1'
  @login_token = '_ZI7ogwaViko1_Q6edPzLg'
end

Then('It should return invalid user-id message for multiple receipts') do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  expect(response_body).to eq('error' => 'Invalid user id/application id.')
end

When(/^I make parser API call with invalid receipt for multiple receipts$/) do
  @url = 'http://mivi-api-staging.herokuapp.com/api/parser'
  @params = {
    picture: [invalid_receipt_1, invalid_receipt_2]
  }
end

Then(/^It should return success for multiple receipts with invalid receipts$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = post @url, @params
  response_body = JSON response.body
  @id = response_body['data']['id']
  expect(response.status).to eq(200)
end

# rubocop:disable LineLength
When(/^I send a GET request to receipt details for multiple receipts with invalid receipts$/) do
  @url = "http://mivi-api-staging.herokuapp.com/api/receipts/#{@id}"
  ReceiptProcessingInteractor.process_receipt(@id)
end
# rubocop:enable LineLength

Then(/^response should have main receipt status manual_processing for multiple receipts$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  expect(response_body['data']['attributes']['status']).to eq('manual_processing')
end
When('I send a GET request to reward_services for multiple receipts with invalid receipts') do
  @url = 'http://mivi-api-staging.herokuapp.com/api/reward_services'
end
# rubocop:enable LineLength

Then('It should return game-token {int} for multiple receipts with invalid receipts') do |int|
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response_body = JSON response.body
  game_token = response_body['data']['attributes']['game-token']
  expect(game_token).to eq(int)
end

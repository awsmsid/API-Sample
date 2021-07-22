# frozen_string_literal: true

# rubocop:disable MixinUsage
include WebMock::API
# rubocop:enable MixinUsage

Given(/^user id and login token$/) do
  @login_token = '_ZI7ogwaViko1_Q6edPzLg'
  @user_id = User.create!(id: 461,
                          email: 'test@gmail.com',
                          password: 'password',
                          password_confirmation: 'password').id
end

When(/^I make POST bill_reminder API call$/) do
  @url = 'http://mivi-api-staging.herokuapp.com/api/bill_reminders'
  @params = {
    data: {
      type: 'bill-reminders',
      attributes: {
        title: 'bill reminder',
        all_day: '0',
        start_date: '1409175049',
        end_date: '1409175049'
      }
    }
  }
end

Then(/^It should return success for bill_reminder$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = post @url, @params
  expect(response.status).to eq(200)
end

When(/^I make GET request to bill_reminder details$/) do
  @url = 'http://mivi-api-staging.herokuapp.com/api/bill_reminders'
  @user_id = 461
  @login_token = '_ZI7ogwaViko1_Q6edPzLg'
end

Then(/^It should have title bill reminder$/) do
  header 'user-session-token', @login_token
  header 'user-id', @user_id
  response = get @url
  response.body.should include('bill reminder')
end

Given(/^user id and invalid login token$/) do
  @login_token = 'pHufpGplLTYJnmWh5cqK'
  @user_id = User.create!(id: 461,
                          email: 'test@gmail.com',
                          password: 'password',
                          password_confirmation: 'password').id
end

When('I make POST bill_reminders API call with wrong login token') do
  @url = 'http://mivi-api-staging.herokuapp.com/api/bill_reminders'
  @params = {
    data: {
      type: 'bill-reminders',
      attributes: {
        title: 'bill reminder',
        all_day: '0',
        start_date: '1409175049',
        end_date: '1409175049'
      }
    }
  }
end

Then('It should return bill_reminders invalid user-session-token message') do
  header 'login_token', @login_token
  header 'user-id', @user_id
  response = get @url
  response.body.should include('Invalid token.')
end

Given(/^invalid user id and login token$/) do
  @login_token = '_ZI7ogwaViko1_Q6edPzLg'
  @user_id = 0
end

When('I make GET bill_reminders API call with wrong user-id') do
  @url = 'http://mivi-api-staging.herokuapp.com/api/bill_reminders'
end

Then('It should return GET bill_reminders invalid user-id message') do
  header 'login_token', @login_token
  header 'user-id', @user_id
  response = get @url
  response.body.should include('Invalid user id/application id.')
end

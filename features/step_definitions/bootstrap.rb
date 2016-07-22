Given(/^a valid service identifier$/) do
  @test.given_valid_service_identifier
end

Given(/^an environment configuration$/) do
  @test.given_environment_configuration
end

When(/^I am bootstrapped$/) do
  @test.bootstrap
end

Then(/^I remember my service identifier$/) do
  expect(@test.has_remembered_service_identifier?).to eq(true)
end

Then(/^I complete bootstrap$/) do
  expect(@test.has_completed_bootstrap?).to eq(true)
end

Given(/^an invalid service identifier$/) do
  @test.given_invalid_service_identifier
end

Then(/^I notify 'invalid service identifier'$/) do
  expect(@test.has_received_notification?('invalid service identifier')).to eq(true)
end

Then(/^I do not complete bootstrap$/) do
  expect(@test.has_completed_bootstrap?).to eq(false)
end

Given(/^no service identifier$/) do
  @test.given_no_service_identifier
end

Given(/^an environment file$/) do
  @test.given_an_environment_file
end

Given(/^the environment file is placed in an expected location$/) do
  @test.given_the_environment_file_is_placed_in_an_expected_location
end

Given(/^a service identifier present in the environment file$/) do
  @test.given_valid_service_identifier
end

Given(/^a service registry URI present in the environment file$/) do
  @test.given_a_service_registry_uri_present_in_the_environment_file
end

Given(/^an authentication service URI present in the environment file$/) do
  @test.given_an_authentication_service_uri_present_in_the_environment_file
end

Given(/^an execution environment indicator present in the environment file$/) do
  @test.given_an_execution_environment_indicator_present_in_the_environment_file
end

Given(/^a configuration service URI present in the environment file$/) do
  @test.given_a_configuration_service_uri_present_in_the_environment_file
end

Given(/^a configuration service token present in the environment file$/) do
  @test.given_a_configuration_service_token_present_in_the_environment_file
end

Given(/^a configuration service provider present in the environment file$/) do
  @test.given_a_configuration_service_provider_present_in_the_environment_file
end

Given(/^a session key present in the environment file$/) do
  @test.given_a_unique_session_key
end

Given(/^a session secret present in the environment file$/) do
  @test.given_a_session_secret
end

Given(/^a failure reading the environment file$/) do
  @test.given_a_failure_reading_the_environment_file
end

Then(/^I can extract the service identifier from the environment file$/) do
  expect(@test.can_extract_the_service_identifier_from_the_environment_file).to eq(true)
end

Then(/^I can extract the service registry URI from the environment file$/) do
  expect(@test.can_extract_the_service_registry_uri_from_the_environment_file).to eq(true)
end

Then(/^I can extract the authentication service URI from the environment file$/) do
  expect(@test.can_extract_the_authentication_service_uri_from_the_environment_file).to eq(true)
end

Then(/^I can extract the execution environment indicator from the environment file$/) do
  expect(@test.can_extract_the_execution_environment_indicator_from_the_environment_file).to eq(true)
end

Then(/^I can extract the configuration service URI from the environment file$/) do
  expect(@test.can_extract_the_configuration_service_uri_from_the_environment_file).to eq(true)
end

Then(/^I can extract the configuration service token from the environment file$/) do
  expect(@test.can_extract_the_configuration_service_token_from_the_environment_file).to eq(true)
end

Then(/^I can extract the configuration service provider from the environment file$/) do
  expect(@test.can_extract_the_configuration_service_provider_from_the_environment_file).to eq(true)
end

Then(/^I can extract the session key from the environment file$/) do
  expect(@test.can_extract_the_session_key_from_the_environment_file).to eq(true)
end

Then(/^I can extract the session secret from the environment file$/) do
  expect(@test.can_extract_the_session_secret_from_the_environment_file).to eq(true)
end

Then(/^I notify 'failure retrieving environment from file'$/) do
  expect(@test.has_received_notification?('failure retrieving environment from file')).to eq(true)
end

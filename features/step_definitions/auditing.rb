TEST_MESSAGE    = 'Something' unless defined? TEST_MESSAGE;    TEST_MESSAGE.freeze
NO_TEST_MESSAGE = ''          unless defined? NO_TEST_MESSAGE; NO_TEST_MESSAGE.freeze
DEBUG_LEVEL     = 'debug' unless defined? DEBUG_LEVEL;   DEBUG_LEVEL.freeze
INFO_LEVEL      = 'info'  unless defined? INFO_LEVEL;    INFO_LEVEL.freeze
WARN_LEVEL      = 'warn'  unless defined? WARN_LEVEL;    WARN_LEVEL.freeze
ERROR_LEVEL     = 'error' unless defined? ERROR_LEVEL;   ERROR_LEVEL.freeze
FATAL_LEVEL     = 'fatal' unless defined? FATAL_LEVEL;   FATAL_LEVEL.freeze

Given(/^an audit event$/) do
  @test.given_audit_message(TEST_MESSAGE)
end

Given(/^no audit event$/) do
  @test.given_audit_message(NO_TEST_MESSAGE)
end

Given(/^a message$/) do
  @test.given_audit_message(TEST_MESSAGE)
end

Given(/^no auditing level$/) do
  puts "Missing audit levels are not testable at the moment, defaulting to debug"
  @test.given_auditing_level(DEBUG_LEVEL)
end

Given(/^a valid auditing level$/) do
  @test.given_auditing_level(DEBUG_LEVEL)
end

Given(/^an invalid auditing level$/) do
  puts "Invalid audit levels are not testable at the moment, defaulting to debug"
  @test.given_auditing_level(DEBUG_LEVEL)
end

Given(/^an auditing level 'debug'$/) do
  @test.given_auditing_level(DEBUG_LEVEL)
end

Given(/^an auditing level 'info'$/) do
  @test.given_auditing_level(INFO_LEVEL)
end

Given(/^an auditing level 'warn'$/) do
  @test.given_auditing_level(WARN_LEVEL)
end

Given(/^an auditing level 'error'$/) do
  @test.given_auditing_level(ERROR_LEVEL)
end

Given(/^an auditing level 'fatal'$/) do
  @test.given_auditing_level(FATAL_LEVEL)
end

Given(/^an optional field$/) do
  @test.given_audit_message('[key:value] message with optional field')
end

Given(/^an empty optional field$/) do
  @test.given_audit_message('[key:] message with empty optional field')
end

Given(/^no optional field$/) do
  @test.given_audit_message('message with no optional field')
end

Given(/^an invalid optional field$/) do
  @test.given_audit_message('[[ message with invalid optional field')
end

Given(/^a flow identifier$/) do
  @test.given_flow_identifier
end

Given(/^a request without a flow identifier$/) do
  @test.given_request_without_flow_identifier
end

Given(/^a request with a flow identifier$/) do
  @test.given_request_with_flow_identifier
end








When(/^I am asked to audit$/) do
  @test.notify_audit
end

When(/^I receive a request$/) do
  #Nothing done here as it is implicit
end

When(/^I need to talk to another service$/) do
  @test.forward_request_with_flow_identifier
end





Then(/^I want to generate a unique flow identifier$/) do
  @test.has_notified_with_new_flow_identifier?
end

Then(/^I want to update the request with the flow identifier$/) do
  @test.has_notified_with_new_flow_identifier?
end

Then(/^I want to use the flow identifier in auditing$/) do
  @test.has_notified_with_flow_identifier?
end

Then(/^I want to use the flow identifier to identify the flow in the new request$/) do
  @test.has_notified_with_flow_identifier_in_new_request?
end








Then(/^I add the audit event to the buffer$/) do
  puts "nothing" # Write code here that turns the phrase above into concrete actions
  expect(true).to eq(false)
end

Then(/^I report the buffered audit event$/) do
  puts "nothing"
  expect(true).to eq(false)
   # Write code here that turns the phrase above into concrete actions
end

Then(/^I report the buffered audit event$/) do
  puts "nothing"
  expect(true).to eq(false)
  pending # Write code here that turns the phrase above into concrete actions
end


Then(/^I notify 'Unknown auditing level'$/) do
  puts "Not testable at the moment"
end

Then(/^I notify an auditing provider of the audit event$/) do
  expect(@test.has_been_notified?).to eq(true)
end

Then(/^I provide the time$/) do
  expect(@test.has_notified_with_timestamp?).to eq(true)
end

Then(/^I provide the time as utc time$/) do
  expect(@test.has_notified_with_utc_timestamp?).to eq(true)
end

Then(/^the time I provide is in utc time$/) do
  expect(@test.has_notified_with_utc_timestamp?).to eq(true)
end

Then(/^the audit event is correctly formatted$/) do
  expect(@test.is_correctly_formatted?).to eq(true)
end

Then(/^I default to 'debug' level$/) do
  expect(@test.has_audited_with_level?(DEBUG_LEVEL)).to eq(true)
end

Then(/^I provide the 'debug' auditing level$/) do
  expect(@test.has_audited_with_level?(DEBUG_LEVEL)).to eq(true)
end

Then(/^I provide the 'info' auditing level$/) do
  expect(@test.has_audited_with_level?(INFO_LEVEL)).to eq(true)
end

Then(/^I provide the 'warn' auditing level$/) do
  expect(@test.has_audited_with_level?(WARN_LEVEL)).to eq(true)
end

Then(/^I provide the 'error' auditing level$/) do
  expect(@test.has_audited_with_level?(ERROR_LEVEL)).to eq(true)
end

Then(/^I provide the 'fatal' auditing level$/) do
  expect(@test.has_audited_with_level?(FATAL_LEVEL)).to eq(true)
end

Then(/^I notify an auditing provider with no audit event$/) do
  expect(@test.has_notified_with_message?(NO_TEST_MESSAGE)).to eq(true)
end

Then(/^I provide my identifier$/) do
  expect(@test.has_notified_with_my_identifier?).to eq(true)
end

Then(/^I provide the optional field$/) do
  @test.has_notified_with_message?('[key:value] message with optional field')
end

Then(/^I provide the empty optional field$/) do
  @test.has_notified_with_message?('[key:] message with empty optional field')
end

Then(/^I provide no optional field$/) do
  @test.has_notified_with_message?('message with no optional field')
end

Then(/^I treat the option field as normal message text$/) do
  @test.has_notified_with_message?('[[ message with invalid optional field')
end

Then(/^I provide the flow identifier$/) do
  @test.has_notified_with_flow_identifier?
end

Then(/^I provide the message$/) do
  @test.has_notified_with_message?('event message')
end

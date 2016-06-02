Feature: Auditing service component actions
  As a service component
  In order to provide transparency
  I want to notify audit events

  Scenario:
    Given an audit event
    And no auditing level
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I default to 'debug' level

  Scenario:
    Given an audit event
    And an invalid auditing level
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I default to 'debug' level
    And I notify 'Unknown auditing level'

  Scenario:
    Given an audit event
    And an auditing level 'debug'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I provide the current time
    And I provide the selected auditing level

  Scenario:
    Given an audit event
    And an auditing level 'info'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I provide the current time
    And I provide the selected auditing level

  Scenario:
    Given an audit event
    And an auditing level 'warn'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I provide the current time
    And I provide the selected auditing level

  Scenario:
    Given an audit event
    And an auditing level 'error'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I provide the current time
    And I provide the selected auditing level

  Scenario:
    Given an audit event
    And an auditing level 'fatal'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I provide the current time
    And I provide the selected auditing level

  Scenario:
    Given no audit event
    And a valid auditing level
    When I am asked to audit
    Then I notify an auditing provider with no audit event
    And I provide my identifier
    And I provide the current time
    And I provide the selected auditing level

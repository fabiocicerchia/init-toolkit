@domain:readiness-waiting @area:command-handoff @from:bin/wait-for
Feature: Starting the main command once dependencies are up
  Lets an operator use wait-for as a wrapper that becomes the real service process once everything it needs is reachable.

  @id:readiness-waiting.command-handoff.001 @rule:readiness.handoff.exec-after-all-up @inferred @source:bin/wait-for#wait_one
  Scenario Outline: The command after -- replaces wait-for once every dependency is up
    Given db.example.com port 5432 accepts connections
    When the operator runs wait-for tcp://db.example.com:5432 -- <command>
    Then the output shows "wait-for: tcp://db.example.com:5432 is up"
    And <result>

    Examples:
      | command                 | result                                                                                                         |
      | ./start-app --port 8080 | ./start-app runs with arguments --port 8080 in place of wait-for, and its exit status is the run's exit status |
      | (nothing)               | wait-for exits with status 0 without starting anything                                                         |

@domain:readiness-waiting @area:timeouts @from:bin/wait-for
Feature: Giving up on a dependency after a deadline
  Gives operators a bounded wait so a missing dependency fails the init container with a clear message instead of hanging forever.

  @id:readiness-waiting.timeouts.001 @rule:readiness.timeouts.fail-after-deadline @inferred @source:bin/wait-for#wait_one
  Scenario Outline: A dependency that never comes up fails the wait after the timeout
    Given nothing is listening on db.example.com port 5432
    When the operator runs wait-for tcp://db.example.com:5432 <timeout-option> -- ./start-app
    Then the output shows "wait-for: waiting for tcp://db.example.com:5432 (timeout <seconds>s)"
    And after about <seconds> seconds of retrying once a second, the error output shows "wait-for: timeout waiting for tcp://db.example.com:5432"
    And wait-for exits with status 1
    And ./start-app is not started

    Examples:
      | timeout-option | seconds |
      | (none)         | 60      |
      | -t 5           | 5       |
      | --timeout 30   | 30      |

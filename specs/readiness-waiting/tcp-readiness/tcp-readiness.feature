@domain:readiness-waiting @area:tcp-readiness @from:bin/wait-for
Feature: Waiting for a TCP dependency
  Lets an operator hold an init container until a database or cache port accepts connections, so the main container never starts against a dead dependency.

  @id:readiness-waiting.tcp-readiness.001 @rule:readiness.tcp.up-when-port-accepts @inferred @source:bin/wait-for#wait_one
  Scenario: A TCP dependency counts as up once its port accepts a connection
    Given a dependency listening on db.example.com port 5432
    When the operator runs wait-for tcp://db.example.com:5432
    Then the output shows "wait-for: waiting for tcp://db.example.com:5432 (timeout 60s)"
    And the output shows "wait-for: tcp://db.example.com:5432 is up"
    And wait-for exits with status 0

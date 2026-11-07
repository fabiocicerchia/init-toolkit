@domain:readiness-waiting @area:multi-target-waits @from:bin/wait-for
Feature: Waiting for several dependencies
  Lets an operator list every dependency of a service in one command and see which one is being waited on.

  @id:readiness-waiting.multi-target-waits.001 @rule:readiness.multi.sequential-each-own-timeout @inferred @source:bin/wait-for#wait_one @questionable
  Scenario: Several dependencies are checked one after another, each with its own timeout
    Given db.example.com port 5432 accepts connections
    And the endpoint http://api.example.com/healthz answers with status 200
    When the operator runs wait-for tcp://db.example.com:5432 http://api.example.com/healthz -t 10
    Then the output shows "wait-for: waiting for tcp://db.example.com:5432 (timeout 10s)" then "wait-for: tcp://db.example.com:5432 is up"
    And then the output shows "wait-for: waiting for http://api.example.com/healthz (timeout 10s)" then "wait-for: http://api.example.com/healthz is up"
    And wait-for exits with status 0

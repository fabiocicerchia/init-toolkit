@domain:health-probes @area:tcp-probe @from:bin/healthcheck-tcp
Feature: Probing a service's health over TCP
  Lets operators give a container a HEALTHCHECK for services that speak no HTTP (databases, brokers) by testing whether a port accepts a connection.

  Background:
    Given the init-toolkit image provides the healthcheck-tcp command

  @id:health-probes.tcp-probe.001 @rule:health-probes.tcp-probe.pass-on-connect @inferred @source:bin/healthcheck-tcp#healthcheck-tcp
  Scenario Outline: The probe passes only when the port accepts a connection
    Given a service at <host> port <port> that <state>
    When the operator runs healthcheck-tcp <host> <port>
    Then the command exits with status <exit>
    And nothing is printed on success

    Examples:
      | host           | port | state               | exit |
      | localhost      | 5432 | accepts connections | 0    |
      | localhost      | 5432 | refuses connections | 1    |
      | db.example.com | 6379 | accepts connections | 0    |

  @id:health-probes.tcp-probe.002 @rule:health-probes.tcp-probe.requires-host-and-port @inferred @source:bin/healthcheck-tcp#healthcheck-tcp
  Scenario Outline: The probe refuses to run without a host and a port
    Given the operator supplies <given>
    When the operator runs healthcheck-tcp with those arguments
    Then an error naming the missing "<missing>" is printed to standard error
    And the command exits with a non-zero status without attempting any connection

    Examples:
      | given                   | missing |
      | no arguments            | host    |
      | only the host localhost | port    |

  @id:health-probes.tcp-probe.003 @rule:health-probes.tcp-probe.no-own-connect-deadline @inferred @source:bin/healthcheck-tcp#healthcheck-tcp @questionable
  Scenario: The probe sets no connection deadline of its own
    Given a host at 203.0.113.10 that silently drops connection attempts to port 5432
    When the operator runs healthcheck-tcp 203.0.113.10 5432
    Then the command keeps waiting until the operating system's connect timeout expires or the caller's own health-check timeout stops it
    And it then exits with a non-zero status

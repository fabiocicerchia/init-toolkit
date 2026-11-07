@domain:health-probes @area:http-probe @from:bin/healthcheck-http
Feature: Probing an HTTP endpoint for container health
  Lets an operator mark a container healthy or unhealthy from a single HTTP request, without putting curl pipelines into their HEALTHCHECK.

  Background:
    Given the healthcheck-http probe is available in the container

  @id:health-probes.http-probe.001 @rule:health-probes.http.success-or-redirect-passes @inferred @source:bin/healthcheck-http#exec curl
  Scenario Outline: An endpoint answering with a success or redirect status passes the probe
    Given the endpoint <url> answers with HTTP status <status>
    When the operator runs healthcheck-http <url>
    Then the probe exits with status 0
    And nothing is printed
    And the redirect, if any, is not followed

    Examples:
      | url                            | status |
      | http://127.0.0.1:8080/healthz  | 200    |
      | http://127.0.0.1:8080/healthz  | 204    |
      | http://app.example.com/healthz | 301    |

  @id:health-probes.http-probe.002 @rule:health-probes.http.unhealthy-endpoint-fails @inferred @source:bin/healthcheck-http#exec curl @questionable
  Scenario Outline: An endpoint that errors or cannot be reached fails the probe
    Given the endpoint http://127.0.0.1:8080/healthz <condition>
    When the operator runs healthcheck-http http://127.0.0.1:8080/healthz
    Then the probe exits with status <exit>
    And no error message is printed

    Examples:
      | condition                    | exit |
      | answers with HTTP status 404 | 22   |
      | answers with HTTP status 503 | 22   |
      | refuses connections          | 7    |

  @id:health-probes.http-probe.003 @rule:health-probes.http.timeout-fails @inferred @source:bin/healthcheck-http#exec curl
  Scenario Outline: An endpoint slower than the timeout fails the probe
    Given the endpoint http://127.0.0.1:8080/healthz takes <delay> seconds to answer
    When the operator runs healthcheck-http http://127.0.0.1:8080/healthz <timeout>
    Then the probe gives up after <limit> seconds
    And the probe exits with a non-zero status

    Examples:
      | delay | timeout | limit |
      | 10    |         | 5     |
      | 10    | 3       | 3     |
      | 4     | 3       | 3     |

  @id:health-probes.http-probe.004 @rule:health-probes.http.url-required @inferred @source:bin/healthcheck-http#URL
  Scenario: The probe refuses to run without a URL
    Given no URL is given
    When the operator runs healthcheck-http
    Then an error containing "usage: healthcheck-http <url> [timeout]" is printed on standard error
    And the probe exits with a non-zero status
    And no request is made

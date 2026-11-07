@domain:readiness-waiting @area:http-readiness @from:bin/wait-for
Feature: Waiting for an HTTP dependency
  Lets an operator hold startup until an HTTP or HTTPS endpoint answers healthily, so dependent services only start once an API is serving.

  @id:readiness-waiting.http-readiness.001 @rule:readiness.http.up-on-success-or-redirect @inferred @source:bin/wait-for#wait_one
  Scenario Outline: An HTTP dependency counts as up only when it answers with a success or redirect status
    Given an endpoint at <url> that answers with status <status>
    When the operator runs wait-for <url> -t 3
    Then <outcome>

    Examples:
      | url                             | status | outcome                                                                                                                      |
      | http://api.example.com/healthz  | 200    | the output shows "wait-for: http://api.example.com/healthz is up" and wait-for exits with status 0                           |
      | https://api.example.com/healthz | 204    | the output shows "wait-for: https://api.example.com/healthz is up" and wait-for exits with status 0                          |
      | http://api.example.com/healthz  | 302    | the output shows "wait-for: http://api.example.com/healthz is up" and wait-for exits with status 0                           |
      | http://api.example.com/healthz  | 404    | wait-for keeps retrying, then reports "wait-for: timeout waiting for http://api.example.com/healthz" and exits with status 1 |
      | http://api.example.com/healthz  | 503    | wait-for keeps retrying, then reports "wait-for: timeout waiting for http://api.example.com/healthz" and exits with status 1 |

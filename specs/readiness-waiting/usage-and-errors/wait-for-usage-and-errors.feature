@domain:readiness-waiting @area:usage-and-errors @from:bin/wait-for
Feature: Help and input errors for wait-for
  Gives operators built-in usage help and distinct exit codes so a misconfigured init container is told apart from a dependency that is down.

  @id:readiness-waiting.usage-and-errors.001 @rule:readiness.usage.help-text @inferred @source:bin/wait-for#wait_one
  Scenario Outline: Asking for help shows the usage summary
    When the operator runs wait-for <flag>
    Then the output shows the usage lines "wait-for tcp://db:5432 [tcp://redis:6379 ...] [-t 60] [-- cmd args...]" and "wait-for http://api:8080/healthz [-t 60] [-- cmd args...]"
    And the output says TCP targets use netcat and HTTP(S) targets must answer 2xx/3xx
    And wait-for exits with status 0

    Examples:
      | flag   |
      | --help |
      | -h     |

  @id:readiness-waiting.usage-and-errors.002 @rule:readiness.usage.input-errors-exit-64 @inferred @source:bin/wait-for#wait_one @questionable
  Scenario Outline: A missing target or an unsupported scheme is refused with exit status 64
    When the operator runs wait-for <arguments>
    Then the error output shows "<message>"
    And wait-for exits with status 64 without retrying
    And ./start-app is not started

    Examples:
      | arguments                              | message                                                   |
      | -t 10 -- ./start-app                   | wait-for: no targets given (see --help)                   |
      | redis.example.com:6379 -- ./start-app  | wait-for: unsupported scheme in 'redis.example.com:6379'  |
      | ftp://files.example.com -- ./start-app | wait-for: unsupported scheme in 'ftp://files.example.com' |

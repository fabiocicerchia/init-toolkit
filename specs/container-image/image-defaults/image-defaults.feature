@domain:container-image @area:image-defaults @from:init-toolkit/dockerfile
Feature: Running the image as an init container
  Operators drop the image into an initContainer or compose service and pass wait-for arguments straight through, with safe defaults when they pass none.

  Background:
    Given the operator has pulled the init-toolkit image

  @id:container-image.image-defaults.001 @rule:image.entrypoint.arguments-go-to-wait-for @inferred @source:Dockerfile#ENTRYPOINT
  Scenario: Arguments given to the container go straight to wait-for
    Given nothing is listening on 127.0.0.1:9999 inside the container
    When the operator runs the image with arguments "tcp://127.0.0.1:9999 -t 2"
    Then wait-for checks 127.0.0.1:9999 for up to 2 seconds
    And the container exits with a non-zero status

  @id:container-image.image-defaults.002 @rule:image.entrypoint.default-shows-help @inferred @source:Dockerfile#CMD
  Scenario: Running the image without arguments shows wait-for's help
    When the operator runs the image with no arguments
    Then the wait-for help text is printed
    And the container exits with status 0

  @id:container-image.image-defaults.003 @rule:image.runtime.no-health-check @inferred @source:Dockerfile#HEALTHCHECK
  Scenario: The image declares no health check of its own
    When the operator runs the image under a runtime that honours image health checks
    Then no health check runs against the container
    And the container is reported with no health status, only its exit code

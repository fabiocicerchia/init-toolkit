# Specifications of init-toolkit

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Container image

The small, hardened image that bundles every helper for init containers and entrypoint wrappers.

- **Entrypoint and defaults**: [Running the image as an init container](container-image/image-defaults/image-defaults.feature) (3)

## Developer tooling

The day-to-day commands contributors use to build, check, run and ship the project.

- **Local installation**: [Installing the helpers on a host](developer-tooling/local-install/local-install.feature) (2)

## Documentation

How the project's documentation site looks and presents itself.

- **Site theme and branding**: [Branding the documentation site](documentation/docs-theme/docs-branding.feature) (1)

## Health probes

One-shot checks suited to container HEALTHCHECK and liveness/readiness probes.

- **HTTP health probe**: [Probing an HTTP endpoint for container health](health-probes/http-probe/http-health-probe.feature) (4)
- **TCP health probe**: [Probing a service's health over TCP](health-probes/tcp-probe/tcp-health-probe.feature) (3)

## Readiness waiting

Blocking startup until the services a workload depends on are reachable, then handing off to the real command.

- **Command handoff**: [Starting the main command once dependencies are up](readiness-waiting/command-handoff/command-handoff.feature) (1)
- **HTTP readiness**: [Waiting for an HTTP dependency](readiness-waiting/http-readiness/http-readiness.feature) (1)
- **Multiple targets**: [Waiting for several dependencies](readiness-waiting/multi-target-waits/multi-target-waits.feature) (1)
- **TCP readiness**: [Waiting for a TCP dependency](readiness-waiting/tcp-readiness/tcp-readiness.feature) (1)
- **Timeouts and retries**: [Giving up on a dependency after a deadline](readiness-waiting/timeouts/readiness-timeouts.feature) (1)
- **Usage and input errors**: [Help and input errors for wait-for](readiness-waiting/usage-and-errors/wait-for-usage-and-errors.feature) (2)

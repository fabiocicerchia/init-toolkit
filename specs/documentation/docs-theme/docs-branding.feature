@domain:documentation @area:docs-theme @from:docs/stylesheets
Feature: Branding the documentation site
  Gives readers of the init-toolkit docs and splash page one consistent, self-hosted look in light and dark mode, so the project reads as part of its portfolio family.

  Background:
    Given the documentation site and the splash page are published together

  @id:documentation.docs-theme.003 @rule:docs.theme.no-network-fonts @inferred @source:docs/stylesheets/extra.css#:root
  Scenario: The docs use the reader's system fonts and download no web font
    When a reader opens a docs page
    Then body text uses the system sans-serif stack starting with -apple-system and Segoe UI
    And code uses the system monospace stack starting with ui-monospace
    And no font or stylesheet is fetched from a third-party host

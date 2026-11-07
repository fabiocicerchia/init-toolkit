@domain:documentation @area:docs-theme @from:docs/stylesheets
Feature: Branding the documentation site
  Gives readers of the init-toolkit docs and splash page one consistent, self-hosted look in light and dark mode, so the project reads as part of its portfolio family.

  Background:
    Given the documentation site and the splash page are published together

  @id:documentation.docs-theme.001 @rule:docs.theme.shared-accent-palette @inferred @source:docs/stylesheets/extra.css#:root @questionable
  Scenario Outline: The docs and the splash page share one accent colour pair
    Given the accent pair is light blue #38bdf8 and blue #3b82f6
    When a reader opens the <page>
    Then the <element> is drawn in <colours>

    Examples:
      | page          | element            | colours                                            |
      | rendered docs | home hero title    | a gradient from #38bdf8 to #3b82f6                 |
      | rendered docs | primary button     | a gradient from #38bdf8 to #3b82f6 with white text |
      | rendered docs | feature card icons | #38bdf8                                            |
      | splash page   | headline           | a gradient from #38bdf8 to #3b82f6                 |
      | splash page   | GitHub button      | a gradient from #38bdf8 to #3b82f6                 |

  @id:documentation.docs-theme.002 @rule:docs.theme.legible-links-per-scheme @inferred @source:docs/stylesheets/extra.css#[data-md-color-scheme="slate"]
  Scenario Outline: Links stay readable in both light and dark mode
    Given the reader's colour scheme is <scheme>
    When a reader opens a docs page
    Then the page background is <background>
    And links are shown in <link colour>

    Examples:
      | scheme | background                                  | link colour |
      | light  | the theme's default white                   | #3b82f6     |
      | dark   | deep navy #0b0f1a, header and tabs included | #38bdf8     |

  @id:documentation.docs-theme.003 @rule:docs.theme.no-network-fonts @inferred @source:docs/stylesheets/extra.css#:root
  Scenario: The docs use the reader's system fonts and download no web font
    When a reader opens a docs page
    Then body text uses the system sans-serif stack starting with -apple-system and Segoe UI
    And code uses the system monospace stack starting with ui-monospace
    And no font or stylesheet is fetched from a third-party host

  @id:documentation.docs-theme.004 @rule:docs.theme.no-placeholder-logo @inferred @source:docs/stylesheets/extra.css#.md-header__button.md-logo
  Scenario: No stand-in logo is shown while the project has no logo of its own
    Given the project has no logo configured
    When a reader opens a docs page
    Then the header shows the site title with no logo icon
    And the navigation title shows no logo icon

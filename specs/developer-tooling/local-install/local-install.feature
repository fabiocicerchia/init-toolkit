@domain:developer-tooling @area:local-install @from:init-toolkit/makefile
Feature: Installing the helpers on a host
  Lets an operator or distro packager put wait-for and the health probes, with their man pages, onto a host or into a staging root without the container image.

  Background:
    Given the operator has a checkout of init-toolkit

  @id:developer-tooling.local-install.001 @rule:tooling.install.places-tools-and-man-pages-under-prefix @inferred @source:Makefile#install
  Scenario Outline: Installing puts the three helpers and their man pages under the chosen prefix
    Given the operator chooses DESTDIR "<destdir>" and PREFIX "<prefix>"
    When the operator runs make install
    Then wait-for, healthcheck-http and healthcheck-tcp are in "<destdir><prefix>/bin" and are executable
    And wait-for.1, healthcheck-http.1 and healthcheck-tcp.1 are in "<destdir><prefix>/share/man/man1" and are read-only for others
    And the operator sees "installed wait-for healthcheck-http healthcheck-tcp into <destdir><prefix>/bin"

    Examples:
      | destdir      | prefix     |
      |              | /usr/local |
      | /tmp/pkgroot | /usr       |

  @id:developer-tooling.local-install.002 @rule:tooling.install.no-default-prefix @inferred @source:Makefile#install @questionable
  Scenario: Installing without a prefix writes into the root of the filesystem
    Given the operator sets neither DESTDIR nor PREFIX
    When the operator runs make install
    Then the helpers are written to "/bin"
    And the man pages are written to "/share/man/man1"
    And the operator sees "installed wait-for healthcheck-http healthcheck-tcp into /bin"

  @id:developer-tooling.local-install.003 @rule:tooling.install.uninstall-removes-installed-files @inferred @source:Makefile#uninstall
  Scenario: Uninstalling removes exactly what installing put down
    Given the helpers and man pages were installed with DESTDIR "/tmp/pkgroot" and PREFIX "/usr"
    When the operator runs make uninstall with the same DESTDIR and PREFIX
    Then wait-for, healthcheck-http and healthcheck-tcp are gone from "/tmp/pkgroot/usr/bin"
    And their three man pages are gone from "/tmp/pkgroot/usr/share/man/man1"
    And the bin and man1 directories themselves are left in place

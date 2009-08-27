As a coder
I want to track my time
In order to correctly invoice my customers

  Scenario: Punch in/out with no prior history
    Given it is "2009-01-01T00:00:00Z"
    When I punch in from "projectA"
    Given 5 minutes pass
    And I list my time entries
    Then I should see:
      | dirname  | date in    | time in | date out | time out | duration | comment |
      | projectA | 2009-01-01 | 00:00   |          |          | 00:05    |         |

    When I punch out from "projectA"
    And I list my time entries
    Then I should see:
      | dirname  | date in    | time in | date out   | time out | duration | comment |
      | projectA | 2009-01-01 | 00:00   | 2009-01-01 | 00:05    | 00:05    |         |

  Scenario: Different project directories
    Given it is "2009-01-01T00:00:00Z"
    And I punch in from "projectA"
    And 13 minutes pass
    And I punch in from "projectB"
    And 42 minutes pass
    And I list my time entries
    Then I should see:
      | dirname  | date in    | time in | date out   | time out | duration | comment |
      | projectA | 2009-01-01 | 00:00   | 2009-01-01 | 00:13    | 00:13    |         |
      | projectB | 2009-01-01 | 00:13   |            |          | 00:42    |         |

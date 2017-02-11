Feature: Format dates in a variety of formats

  Scenario Outline: Dates with just a month and no default year
    Given the string "<date_string>" to represent a date
    When that string is parsed
    Then we get "nil", "<month>", "nil" extracted from it

    Examples:
      | date_string | month |
      | 01          | 1     |
      | 2           | 2     |
      | 11          | 11    |
      | Dec         | 12    |
      | Sept        | 9     |
      | March       | 3     |

  Scenario Outline: Dates with just a month and a default year
    Given the string "<date_string>" to represent a date
      And a default year of <year>
    When that string is parsed
    Then we get "nil", "<month>", "<year>" extracted from it

    Examples:
      | date_string | month | year |
      | 7           | 7     | 1900 |
      | Sep         | 9     | 2012 |
      | August      | 8     | 1973 |

  Scenario Outline: Dates with a month and a year
    Given the string "<date_string>" to represent a date
    When that string is parsed
    Then we get "nil", "<month>", "<year>" extracted from it

    Examples:
      | date_string | month | year |
      | 6-1901      | 6     | 1901 |
      | 01/01       | 1     | 2001 |
      | Oct 2013    | 10    | 2013 |
      | December-99 | 12    | 1999 |

  Scenario Outline: Dates with a day, a (non-integer) month and a default year
    Given the string "<date_string>" to represent a date
      And a default year of <year>
    When that string is parsed
    Then we get "<day>", "<month>", "<year>" extracted from it

    Examples:
      | date_string | day | month | year |
      | 10 June     | 10  | 6     | 1901 |
      | 4/July      | 4   | 7     | 2000 |
      | 29-Feb      | 29  | 2     | 2013 |

  Scenario Outline: Dates with a day, a month and a year
    Given the string "<date_string>" to represent a date
    When that string is parsed
    Then we get "<day>", "<month>", "<year>" extracted from it

    Examples:
      | date_string | day | month | year |
      | 10 May 72   | 10  | 5     | 1972 |
      | 5/Nov/2006  | 5   | 11    | 2006 |
      | 1-1-01      | 1   | 1     | 2001 |

   Scenario Outline: Any dates with a day featuring an ordinal indicator
    Given the string "<date_string>" to represent a date
      And a default year of <default_year>
    When that string is parsed
    Then we get "<day>", "<month>", "<year>" extracted from it

    Examples:
      | date_string      | day | month | year | default_year |
      | 11th 01          | 11  | 1     | 1901 | 1901         |
      | 1st May 09       | 1   | 5     | 2009 | 2005         |
      | 2nd June         | 2   | 6     | nil  | nil          |
      | 23rd August 1973 | 23  | 8     | 1973 | nil          |

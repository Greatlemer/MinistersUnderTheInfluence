Feature: Parse Data Layouts
  The processor should be able to process files in a variety of layouts

  Scenario: Process Four Column, No Preamble
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      Minister,Date,External Organisation,Reason
      The PM,02 Jan 1995,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,The PM,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,1
      """

  Scenario: Process Four Column, No Preamble, Empty Minister Heading
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      ,Date,External Organisation,Reason
      The PM,02 Jan 1995,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,The PM,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,1
      """

  Scenario: Process Four Column, No Preamble, Minister Heading is "SPAD"
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      SPAD,Date,External Organisation,Reason
      An Advisor,02 Jan 1995,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,An Advisor,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,1
      """

  Scenario: Process Four Column, No Preamble, Minister Heading is "Special Advisor"
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      Special Advisor,Date,External Organisation,Reason
      An Advisor,02 Jan 1995,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,An Advisor,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,1
      """

  Scenario: Process Four Column, No Preamble, Minister Heading is "Permanent Secretary"
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      Permanent Secretary,Date,External Organisation,Reason
      Perm Sec,02 Jan 1995,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,Perm Sec,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,1
      """

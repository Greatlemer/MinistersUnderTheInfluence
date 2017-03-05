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
      Date,Special Advisor,External Organisation,Reason
      02 Jan 1995,An Advisor,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,An Advisor,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,1
      """

  Scenario: Process Four Column, No Preamble, Minister Heading is "Special Adviser"
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      Date,Special Adviser,External Organisation,Reason
      02 Jan 1995,An Adviser,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,An Adviser,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,1
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

  Scenario: Process Four Column, No Preamble, Date Heading is "Month"
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      Permanent Secretary,Month,External Organisation,Reason
      Perm Sec,June,British Telecom,It's good to talk
      """
      And a default year for the file of 1999
    When the file is processed
    Then the cleaned output should be
      """
      1,Perm Sec,,Transparency Office,06-1999,06-1999,British Telecom,,It's good to talk,0,Transparent.csv,1
      """

  Scenario: Data has preamble at start of the file
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      This is unneccesary preamble
      That nobody cares about, but may still look like lines. The data appears next.
      Minister,Date,External Organisation,Reason
      The PM,02 Jan 1995,British Telecom,It's good to talk
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,The PM,,Transparency Office,02-01-1995,02-01-1995,British Telecom,,It's good to talk,0,Transparent.csv,3
      """

  Scenario: Process Four Column, Organisation column headed as 'Name'
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      Special Advisers,Date,Name,Purpose of Meeting
      SPAD1,June 2000,Jim Jameson,Advice
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,SPAD1,,Transparency Office,06-2000,06-2000,Jim Jameson,,Advice,0,Transparent.csv,1
      """

  Scenario: Process Four Column, NIL in the date column is equivalent to an empty row
    Given a data file named "Transparent.csv" from the "Transparency Office" containing
      """
      Minister,Date,Organisation,Purpose of Meeting
      Rt Hon No Meetings,NIL,,
      Rt Hon Saw Someone, 08-99, My mate,Drinks
      """
    When the file is processed
    Then the cleaned output should be
      """
      1,Rt Hon Saw Someone,,Transparency Office,08-1999,08-1999,My mate,,Drinks,0,Transparent.csv,2
      """

Feature: Parse Data Layouts
  The processor should be able to process files in a variety of layouts

  Scenario: Process Four Column No Preamble
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

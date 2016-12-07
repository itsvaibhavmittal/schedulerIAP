Feature: Administrator can manage Events

  As an administrator
  I want to add events to the event list database
  So that I create new events apart from existing ones

  Background: User is logged in
    Given I am on the home page
    And I enter correct user information
    And I fill in "Email" with "jay@aa.com"
    And I fill in "Password" with "123123"
    When I press "Log in"
    Then I should be on the sessions page
# Scenario to check Successful Creation
# When all fields are entered correctly
  Scenario: Enter the event information
    Given I am on the new event page
    And I fill in "Event Name" with "Mock Interview"
    And I select "November 1, 2015" as the "Event Date"
    And I select "10 AM:00" as "Start Time"
    And I select "11 AM:00" as "End Time"
    And I check "For Students"
    And I fill in "Student Capacity" with "20"
    And I fill in "Timeslot Duration" with "20"

    When I press "Create"

    Given I have entered the event's information
    Then I should be on the view event information page
    When I click on "Edit"
    Then I should be on the edit event's information page

    When I click on "Back"
    Then I should be on the events page

# Scenario to check retaining data
# When some fields are entered (others blank)
  Scenario: Enter event information partially
    Given I am on the new event page
    And I fill in "Event Name" with "Resume Clinic"
    And I select "November 1, 2015" as the "Event Date"
    And I fill in "Student Capacity" with "20"
    And I check "For Students"


    When I press "Create"

    Given I have entered the event's information
    Then I should be on the events page
    And the "Event Name" field should contain "Resume Clinic"

    And the "Student Capacity" field should contain "20"
    And the "Timeslot Duration" field should have the error "can't be blank"

    And the "For Students" checkbox should be checked
    

# Scenario to check Successful Editing
# When all fields are entered correctly
  Scenario: Edit the event information
    Given I am on the new event page
    And I fill in "Event Name" with "Mock Interview 2"
    And I select "November 1, 2015" as the "Event Date"
    And I select "10 AM:00" as "Start Time"
    And I select "11 AM:00" as "End Time"
    And I check "For Students"
    And I fill in "Student Capacity" with "20"
    And I fill in "Timeslot Duration" with "20"
    When I press "Create"
    Given I have entered the event's information
    Then I should be on the view event information page
    When I click on "Edit"
    Then I should be on the edit event's information page
    When I press "Edit"
    Then I should be on the view event information page
    When I click on "Edit"
    Then I should be on the edit event's information page
    And I fill in "Event Name" with ""
    When I press "Edit"
    Then I should be on the view event information page


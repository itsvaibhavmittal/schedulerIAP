Feature: Students can enter their Information

  As a student
  I want to retain the entered information
  So that I can edit them back easily

Background: User is logged in
    Given I am on the home page
    And I enter correct user information
    And I fill in "Email" with "jay@aa.com"
    And I fill in "Password" with "123123"
    When I press "Log in"
    Then I should be on the sessions page
    Given I am on the new event page
    And I fill in "Event Name" with "Mock_1"
    And I select "November 11, 2015" as the "Event Date"
    And I select "10 AM:00" as "Start Time"
    And I select "11 AM:00" as "End Time"
    And I check "For Students"
    And I fill in "Student Capacity" with "20"
    And I fill in "Timeslot Duration" with "20"
    When I press "Create"
    Given I have entered the event's information
    Then I should be on the view event information page

    Given I am on the new event page
    And I fill in "Event Name" with "Mock_2"
    And I select "November 11, 2015" as the "Event Date"
    And I select "01 PM:00" as "Start Time"
    And I select "03 PM:00" as "End Time"
    And I check "For Students"
    And I fill in "Student Capacity" with "30"
    And I fill in "Timeslot Duration" with "20"
    When I press "Create"
    Given I have entered the event's information
    Then I should be on the view event information page



# Scenario to check Successfull Registration
# When all fields are entered correctly
Scenario: Enter edit and update the student information

	Given I am on the new student page
	And I fill in "Name" with "John"
	And I fill in "UIN" with "123541459"
	And I fill in "Email" with "komanduri1289@tamu.edu"
	And I check "I am a US-Citizen"
	And I select "B.S." from "Student Level"
	And I select "Internship" from "Job Type"
	And I select "10:00AM-10:20AM" from "Mock_1"
	And I select "Not Attend" from "Mock_2"


	When I press "Submit"

	Given I have entered my information
	Then I should be on the view student information page
	When I click on "Edit"
	Then I should be on the edit information page
	And I fill in "Name" with "John"
	And I fill in "UIN" with "123541459"
	And I fill in "Email" with "afdldw@alkdfjl.com"
	And I check "I am a US-Citizen"
	And I select "B.S." from "Student Level"
	And I select "Internship" from "Job Type"
	And I select "10:00AM-10:20AM" from "Mock_1"
	And I select "Not Attend" from "Mock_2"


	When I press "Submit"

	Given I have entered my information
	Then I should be on the view student information page
	When I click on "Edit"
	Then I should be on the edit information page

	When I click on "Back"
	Then I should be on the students page

Scenario: Fail to update the student information
	
	Given I am on the new student page
	And I fill in "Name" with "John"
	And I fill in "UIN" with "123541459"
	And I fill in "Email" with "afdldw@alkdfjl.com"
	And I uncheck "I am a US-Citizen"
	And I select "M.S." from "Student Level"
	And I select "Internship" from "Job Type"
	And I select "10:00AM-10:20AM" from "Mock_1"
	And I select "Not Attend" from "Mock_2"


	When I press "Submit"

	Given I have entered my information
	Then I should be on the view student information page
	When I click on "Edit"
	Then I should be on the edit information page
	And I fill in "Name" with "John"
	And I fill in "UIN" with "123541459"
	And I fill in "Email" with "afdldwcom"
	And I uncheck "I am a US-Citizen"
	And I select "M.S." from "Student Level"
	And I select "Internship" from "Job Type"
	And I select "10:00AM-10:20AM" from "Mock_1"
	And I select "Not Attend" from "Mock_2"


	When I press "Submit"

	Given I have entered my information
	Then I should be on the edit information page

	And the "Name" field should contain "John" 

	And the "Email" field should contain "afdldw@alkdfjl.com" 

	And the "UIN" field should contain "123541459"

	And the "I am a US-Citizen" checkbox should not be checked

	And the "Student Level" field should contain "M.S" 

	And the "Job Type" field should contain "Internship" 


# Scenario to check retaining data
# When only some fields are entered (others blank)
Scenario: Enter correct student information partially
  Given I am on the new student page
  And I fill in "Email" with "trail@blazers.com"
  And I check "I am a US-Citizen"
  And I select "10:00AM-10:20AM" from "Mock_1"
  And I select "Not Attend" from "Mock_2"

  When I press "Submit"

  Given I have entered my information
  Then I should be on the students page  

  And the "Email" field should contain "trail@blazers.com" 
  
  
  And the "I am a US-Citizen" checkbox should be checked
  
# Scenario to check retaining data
# When one field is entered incorrectly (others correct)
Scenario: Enter incorrect student information
	Given I am on the new student page
	And I fill in "Name" with "Trail"
	And I fill in "Email" with "trail@.com"
	And I fill in "UIN" with "123456789"
	And I uncheck "I am a US-Citizen"
	And I select "M.S." from "Student Level"
	And I select "Internship" from "Job Type"
	And I select "10:00AM-10:20AM" from "Mock_1"
	And I select "Not Attend" from "Mock_2"

	When I press "Submit"
	
	Given I have entered my information
	Then I should be on the students page

  And the "Name" field should contain "Trail" 
  
  And the "Email" field should contain "trail@.com" 
  
  And the "UIN" field should contain "123456789"
  
  And the "I am a US-Citizen" checkbox should not be checked
  
  And the "Student Level" field should contain "M.S" 
  
  And the "Job Type" field should contain "Internship" 
  

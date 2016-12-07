Feature: Administrator can manage Companies

  As an administrator
  I want to edit companies
  So that I change company schedule if necessary

  Background: User is logged in
    Given I am on the home page
    And I enter correct user information
    And I fill in "Email" with "jay@aa.com"
    And I fill in "Password" with "123123"
    When I press "Log in"
    Then I should be on the sessions page
# Scenario to check Successful Creation, Edit & Submit
# When all fields are entered correctly
		Scenario: Enter the company information, edit and save
    Given I am on the new event page
    And I fill in "Event Name" with "Mock Interview"
    And I select "November 11, 2015" as the "Event Date"
    And I select "10 AM:00" as "Start Time"
    And I select "11 AM:00" as "End Time"
    And I check "For Students"
		And I check "For Companies"
    And I fill in "Student Capacity" with "20"
    And I fill in "Timeslot Duration" with "20"
    When I press "Create"
    Given I have entered the event's information
    Then I should be on the view event information page
		Given I am on the new company page
		And I fill in "Enter your company name" with "Google"
		And I fill in "company[rep_1]" with "Gao Zhuoyang"
		And I fill in "Name" with "Gao Zhuoyang"
		And I fill in "Email" with "gaozhuoyang@gmail.com"
		And I select "Gold" from "Select your company's membership level"
		And I select "Any" from "Select if you hire US citizens only, or not"
		And I select "Internship" from "Select the job type you are offering"
		And I check "company_student_level_ms"
		And I select "2" from "Mock Interview on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
		And I press "Submit"
		Given I have entered the company's information
		Then I should be on the view company information page
		When I click on "Edit"
		Then I should be on the edit company's information page
		When I press "Submit"
		Then I should be on the view company information page
		Scenario: Enter the company information, edit wrongly and save
		Given I am on the new company page
		And I fill in "Enter your company name" with "Google"
		And I fill in "company[rep_1]" with "Gao Zhuoyang"
		And I fill in "Name" with "Gao Zhuoyang"
		And I fill in "Email" with "gaozhuoyang@gmail.com"
		And I select "Gold" from "Select your company's membership level"
		And I select "Any" from "Select if you hire US citizens only, or not"
		And I select "Internship" from "Select the job type you are offering"
		And I check "company_student_level_ms"
		And I press "Submit"
		Given I have entered the company's information
		Then I should be on the view company information page
		When I click on "Edit"
		Then I should be on the edit company's information page
		When I fill in "Email" with " "
		And I press "Submit"
		Then I should be on the view company information page

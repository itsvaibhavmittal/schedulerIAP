Feature: Companies can enter their Infomation

Background: User is logged in
  Given I am on the home page
  And I enter correct user information
  And I fill in "Email" with "jay@aa.com"
  And I fill in "Password" with "123123"
  When I press "Log in"
  Then I should be on the sessions page

Scenario: Enter the company information correctly
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
		And I fill in "Email" with "komanduri1289@tamu.edu"
		And I select "Gold" from "Select your company's membership level"
		And I select "Any" from "Select if you hire US citizens only, or not"
		And I select "Internship" from "Select the job type you are offering"
		And I check "company_student_level_ms"
		And I select "2" from "Mock Interview on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
		And I press "Submit"
		Given I have entered the company's information
		Then I should be on the view company information page

Scenario: Retaining Company information on entering an incorrect data
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
		And I fill in "Email" with "gaozhuoyang.gmail.com"
		And I select "Gold" from "Select your company's membership level"
		And I select "Any" from "Select if you hire US citizens only, or not"
		And I select "Internship" from "Select the job type you are offering"
		And I check "company_student_level_ms"
		And I select "2" from "Mock Interview on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
		And I press "Submit"
		Given I have entered the company's information

    Given I have entered the company's information
    Then I should be on the companies page
    And the "Enter your company name" field should contain "Google"
    And the "company[rep_1]" field should contain "Gao Zhuoyang"
    And the "Name" field should contain "Gao Zhuoyang"
    And the "Email" field should contain "gaozhuoyang.gmail.com" 
    And the "Select your company's membership level" field should contain "Gold"
		And the "Select if you hire US citizens only, or not" field should contain "Any"
    And the "Select the job type you are offering" field should contain "Internship"
    And the "company_student_level_ms" checkbox should be checked
  
Scenario: Enter the company information correctly
    Given I am on the new event page
    And I fill in "Event Name" with "Mock Interview 1"
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
		And I select "2" from "Mock Interview 1 on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
		And I press "Submit"
		Given I have entered the company's information
		Then I should be on the view company information page

    Given I am on the new event page
    And I fill in "Event Name" with "Mock Interview 2"
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

    Given I am on the companies page
    When I click on "Edit"
    Then I should be on the edit company's information page 

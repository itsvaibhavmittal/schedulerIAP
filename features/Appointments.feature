Feature: Administrator can manage Appointments

  As an administrator
  I want to generate appointments between students and companies
  So that the students can meet company representatives for each event

  Background: User is logged in
    Given I am on the home page
    And I enter correct user information
    And I fill in "Email" with "jay@aa.com"
    And I fill in "Password" with "123123"
    When I press "Log in"
    Then I should be on the sessions page

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
    And I fill in "company[rep_2]" with "Vaibhav Mittal"
    And I fill in "Name" with "Gao Zhuoyang"
    And I fill in "Email" with "trailblaze@tamu.edu"
    And I select "Silver" from "Select your company's membership level"
    And I select "US Citizen Only" from "Select if you hire US citizens only, or not"
    And I select "Internship" from "Select the job type you are offering"
  	And I check "company_student_level_bs"
    And I select "2" from "Mock Interview on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
    And I press "Submit"
    Given I have entered the company's information
    Then I should be on the view company information page

    Given I am on the new company page
    And I fill in "Enter your company name" with "Apple"
    And I fill in "company[rep_1]" with "Gao Zhuoyang"
    And I fill in "company[rep_2]" with "Vaibhav Mittal"
    And I fill in "Name" with "Gao Zhuoyang"
    And I fill in "Email" with "tralblaz@tamu.edu"
    And I select "Gold" from "Select your company's membership level"
    And I select "US Citizen Only" from "Select if you hire US citizens only, or not"
    And I select "Internship" from "Select the job type you are offering"
  	And I check "company_student_level_bs"
    And I select "2" from "Mock Interview on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
    And I press "Submit"
    Given I have entered the company's information
    Then I should be on the view company information page
    
    Given I am on the new company page
    And I fill in "Enter your company name" with "Facebook"
    And I fill in "company[rep_1]" with "Gao Zhuoyang"
    And I fill in "company[rep_2]" with "Vaibhav Mittal"
    And I fill in "Name" with "Gao Zhuoyang"
    And I fill in "Email" with "trailblaz@tamu.edu"
    And I select "Bronze" from "Select your company's membership level"
    And I select "US Citizen Only" from "Select if you hire US citizens only, or not"
    And I select "Internship" from "Select the job type you are offering"
  	And I check "company_student_level_bs"
    And I select "2" from "Mock Interview on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
    And I press "Submit"
    Given I have entered the company's information
    Then I should be on the view company information page
    
    Given I am on the new company page
    And I fill in "Enter your company name" with "Microsoft"
    And I fill in "company[rep_1]" with "Gao Zhuoyang"
    And I fill in "company[rep_2]" with "Vaibhav Mittal"
    And I fill in "Name" with "Gao Zhuoyang"
    And I fill in "Email" with "trailblze@tamu.edu"
    And I select "Platinum" from "Select your company's membership level"
    And I select "US Citizen Only" from "Select if you hire US citizens only, or not"
    And I select "Internship" from "Select the job type you are offering"
  	And I check "company_student_level_bs"
    And I select "2" from "Mock Interview on Wednesday 11-11-2015 from 10:00AM to 11:00AM"
    And I press "Submit"
    Given I have entered the company's information
    Then I should be on the view company information page
    
    
    Given I am on the new student page
    And I fill in "Name" with "John"
    And I fill in "UIN" with "123541459"
    And I fill in "Email" with "afdldw@alkdfjl.com"
    And I check "I am a US-Citizen"
    And I select "B.S." from "Student Level"
    And I select "Internship" from "Job Type"
    And I select "10:00AM-10:20AM" from "Mock Interview"
    When I press "Submit"
    Given I have entered my information
    Then I should be on the view student information page

    Given I am on the new student page
    And I fill in "Name" with "Rahul"
    And I fill in "UIN" with "123541123"
    And I fill in "Email" with "afdldw@tamu.edu"
    #And I uncheck "I am a US-Citizen"
    And I select "M.S." from "Student Level"
    And I select "Full-time" from "Job Type"
    And I select "10:00AM-10:20AM" from "Mock Interview"
    When I press "Submit"
    Given I have entered my information
    Then I should be on the view student information page

  Scenario: Enter the appointment information
    Given I am on the new appointment page
    And I fill in "Section" with "Resume Clinic 1"
    And I fill in "Time slot" with "10:30AM-11:00AM"
    And I fill in "Company" with "Microsoft"
    And I fill in "Student" with "Vaibhav"
    And I fill in "UIN" with "123009876"
    When I press "Submit"
    Given I have entered the appointment information
    Then I should be on the view appointment page
    When I click on "Edit"
    Then I should be on the edit appointment's information page
    When I click on "Back"
    Then I should be on the appointments page

  Scenario: Enter the partial appointment information
    Given I am on the new appointment page
    And I fill in "Section" with "Resume Clinic 1"
    When I press "Submit"
    Given I have entered the appointment information
    Then I should be on the appointments page

  Scenario: Generate appointments
    Given I am on the appointments page
    When I click on "Generate"
    Then I should be on the appointments page

  Scenario: Update appointment
    Given I am on the new appointment page
    And I fill in "Section" with "Resume Clinic 1"
    And I fill in "Time slot" with "10:30AM-11:00AM"
    And I fill in "Company" with "Microsoft"
    And I fill in "Student" with "NewStudent"
    And I fill in "UIN" with "123008826"
    When I press "Submit"
    Given I have entered the appointment information
    Then I should be on the view appointment page
    When I click on "Edit"
    Then I should be on the edit appointment's information page
    When I press "Submit"
    Then I should be on the view appointment page
    
  Scenario: Update partial appointment
    Given I am on the new appointment page
    And I fill in "Section" with "Resume Clinic 1"
    And I fill in "Time slot" with "10:30AM-11:00AM"
    And I fill in "Company" with "Microsoft"
    And I fill in "Student" with "NewStudent2"
    And I fill in "UIN" with "123008827"
    When I press "Submit"
    Given I have entered the appointment information
    Then I should be on the view appointment page
    When I click on "Edit"
    Then I should be on the edit appointment's information page
    And I fill in "Company" with ""
    When I press "Submit"
    Then I should be on the view appointment page
    When I press "Submit"
    Then I should be on the view appointment page

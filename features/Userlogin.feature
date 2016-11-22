Feature: Administrator can log in to manage students 

  In order to manage student information
  As an administrator
  I want to log in into the system


Scenario: Log in with incorrect user information
	Given I am on the home page
	When I fill in "Email" with "username that does not exist"
	And I fill in "Password" with "incorrect password"
	And I press "Log in"
	Then I should be on the login page
	And I should see "Invalid email/password combination"

Scenario: Log in with correct user information
	Given I am on the home page
	And I enter correct user information
	And I fill in "Email" with "jay@aa.com"
	And I fill in "Password" with "123123"
	When I press "Log in"
	Then I should be on the sessions page
	And I should see "Weclome administrator : Jay"

	#Then I want to test the student management
	When I click on "Student Infomation"
	Then I should be on the students page
	
	When I click on "Company Infomation"
	Then I should be on the companies page

	When I click on "Event Management"
	Then I should be on the events page

	When I click on "Schedule List"
	Then I should be on the appointments page

	When I click on "New Administrator Account"
	Then I should be on the new useradd page

	When I click on "Log Out"
	And I confirm to del_path
	Then I should be on the home page



	
	# Then I want to test the record management
	
	# When I click on "New Student"
	# Then I should be on the new student page
	# When I click on "Edit"
	# Then I should be on the edit information page


# Industrial Affiliates Program Scheduler
![Ruby 2.2.0p0](https://img.shields.io/badge/Ruby-2.2.0p0-e0115f.svg) ![Rails 4.2.1](https://img.shields.io/badge/Rails-4.2.1-orange.svg)

This is a schedule manager for the [Texas A&M Department of Computer science and Engineering IAP](https://engineering.tamu.edu/cse/iap).

# How to use the app
## Ruby version
We used ruby version 2.2.0p0 and it is recommended that you use [Ruby Version Manager](https://rvm.io/rvm/install) to manage your ruby versions.

## Running on a Heroku app
If you need to create a new Heroku app, you can [follow the instructions on Heroku's website](https://devcenter.heroku.com/articles/creating-apps) to create and deploy to one. Another way, (and the way it is done as of writing this) is to use Heroku's web interface to sign in and create a new app, then on the 'deploy' tab link the app to a specific branch of your repo. Heroku will then mirror this branch, rebuilding and restarting every time changes are pushed to the branch. We do it this way since this is just easier to keep track of, not having a second remote repo, and it comes with the option to manually deploy any branch from the github repo temporarily, which we used often for testing.

### Running commands on your Heroku server
Regardless of the means used to deploy to the Heroku app, you can still run commands on it using the Heroku CLI. After logging in, you can execute commands on the server by running `heroku run [COMMAND] [--app APPNAME]`.

### Using environment variables
Heroku allows the use of [environment variables](https://devcenter.heroku.com/articles/config-vars). This repo currently uses them to store both variable information and also sensitive information like the login and password of the email account used to send emails. 

## Configuring the server for the first time
To configure a new server (such as a local server) have bundler install the gems:

    bundle install

### Database creation
This app uses PostgreSQL. Versions 8.2 and up are supported. To install Postgres, follow the steps listed below:

####Install PostgreSQL 

OS X with Homebrew:
https://launchschool.com/blog/how-to-install-postgresql-on-a-mac

OS X with Macports:
https://github.com/codeforamerica/ohana-api/wiki/Installing-PostgreSQL-with-MacPorts-on-OS-X

Windows systems:
The top response on this thread does a fantastic job of listing all the necessary install steps in detail.
http://stackoverflow.com/questions/7086654/installing-postgres-on-windows-for-use-with-ruby-on-rails


####Install and configure postgres gem

Install the pg driver (if not already installed via bundler):
  gem install pg
On OS X with Homebrew:
  gem install pg -- --with-pg-config=/usr/local/bin/pg_config
On OS X with MacPorts:
  gem install pg -- --with-pg-config=/opt/local/lib/postgresql84/bin/pg_config
On Windows:
  gem install pg
      Choose the win32 build.
      Install PostgreSQL and put its /bin directory on your path.

### Database initialization

Once you have installed postgres and created your database, run the following commands to initialize the app's database:
	
	rake db:migrate
    rake db:seed 
    

### Admin creation
This must be done on a new deployment before attempting to log in for the first time so this is an account to log in with. After ensuring the database is up and running, open the rails console by typing `rails c` and enter the following:

    >> Useradd.create(name: "name", email: "name@tamu.edu", password: "123456", password_confirmation: "123456")
    
You can leave the console by executing `exit`.

## Maintenance
### Testing
Make sure the PostgreSQL server is configured and running, then run the following:

    bundle install
    bundle binstubs rspec-core
    bundle exec rake db:migrate db:test:prepare

in bin directory:

    chmod +x rspec
    bin/rspec

### Mail server
In lieu of a permanent solution to sending emails, we use a gmail account set up by the previous team. If you have a server running and it is not sending emails, (it's set up to report unsuccessful messages in the logs, run `heroku logs` to check) there are only three things that might stop it from happening:

1. The username or password was incorrect
2. The "allow less secure apps" setting is disabled in the account's settings
    * If this is the case, log into the account on mail.google.com and change it, there's likely already a message in the inbox telling you of such.
3. Google does not recognize the server and denies the SMTP request
    * Google does this because the account is intended to be a personal account accessed by one person in one location at a time. If you log into the account, there will be a message in your inbox informing you of a new access. The solution is to go to [this Google website](https://accounts.google.com/DisplayUnlockCaptcha) and log in with the account's credentials, then hit continue. The next time your app tries to send an email it should work.
    
##### Editable Emails
The emails that are currently being sent out include: Register Company, Delete Company, Register Student, Delete Student, and Student Reminder. The required entries for the EmailMessage model that correspond with these messages are implemented in the seed file. As such, you MUST run rake db:seed after your initial migrations for the app. 

# Notes for future development
Our client has expressed the desire to continue the development of the app after our team is finished. For the benefit of future teams, the following are things we recommend addressing.

## User Authentication
The app currently uses a custom made user class. I would recommend stripping this out of the app and installing the devise gem. It allows for a number of things, but namely a differentiation between admins and users. The github for the gem and instructions on how to use it are located below. 

https://github.com/plataformatec/devise
http://railscasts.com/episodes/209-devise-revised

## A better mail service
### The problem with Gmail
The gmail account is intended for use by one person in one place at a time and Google makes it difficult to use it on a server or deployment. This actually isn't Google actively preventing us from using it, it's just them implementing good security features that make sense for personal usage.

Our username and password for our gmail account are no longer stored in this repo for the simple fact that the only thing needed to change the password is the current password (another problem using gmail like this causes). If you need the password, it is in the environment variables of our Heroku deployments.

### Mailgun
Mailgun is a service designed exactly for what it is we need to do. It would solve many of the problems we had with the gmail account implementation, and it would allow for a more professional appearance to the email address and domain. We tried extensively to set up a Mailgun account for this app, but were ultimately unsuccessful.

The way to do this is as follows:

1. **Acquire a custom domain for the Heroku app.**
    * This is what stopped us. None of the documentation online says that this is necessary, but it is.
2. Go to the plugins page on the heroku app website and install the Mailgun plugin.
    * The owner of your app needs to be a verified account (They require the registration of a form of payment, even for these free services).
3. Once the plugin is installed, click on the mailgun name to be taken to the app specific mailgun account, and follow the steps for "Getting started".
    * This will involve verifying the account, adding your custom domain, and setting up some things with your DNS server. That last part is why a custom domain is necessary.
4. Follow [these instructions](https://devcenter.heroku.com/articles/mailgun) to adapt the code to use the proper credentials.

## Disabled Event Security
### Current Implementation
If an event is disabled, currently, the event timeslot selector for students is shown but disabled and a hidden input has the existing value.  This is to combat the problem that disabled inputs on forms do not submit anything.  As a result, not including the hidden input would result in the previous value being set to empty.  This means, however, there is a security vulnerability as anyone can change the hidden input's value using an HTMl editor.
### Preventing This Vulnerability
This could be prevented by making the system only change editable events, so that when event editing is disabled, students cannot modify it.  However, admins should be able to change the value regardless whether editable or not.

## Appointment Matching Algorithm
### Current Implementation
Based on the implemented algorithm, when the "generate" button is pressed, all existing appointments are removed and then the system generates new appointments.  However, this means that any manual changes will be undone.
### Ideal Implementation
The matching algorithm should take into account previously assigned timeslots and not remove them.  However, as the system now has the ability for students to change selected timeslots, it would need to work around students changing timeslots.


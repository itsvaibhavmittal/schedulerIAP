# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

      when /^the home\s?page$/
        '/sessions/new'

      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      when /^the view student information page$/i
        #'/students/1'
        student_path(@student)

      when /^the view company information page$/i
        company_path(@company)

      when /^the edit information page$/i
        edit_student_path(@student)

      when /^the new event page$/i
        new_event_path(@event)

      when /^the view event information page$/i
        event_path(@event)

      when /^the view appointment page$/i
        appointment_path(@appointment)

      when /^the edit appointment's information page$/i
        edit_appointment_path(@appointment)

      when /^the edit event's information page$/i
        edit_event_path(@event)

      when /^the edit company's information page$/i
        edit_company_path(@company)

      when /^the show useradd information page$/i
        useradd_path(@useradd)

      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                    "Now, go and add a mapping in #{__FILE__}"
        end
    end
  end
end

World(NavigationHelpers)

class Event < ActiveRecord::Base
  has_many :timeslots, :dependent => :destroy
  has_many :companyevents, :dependent => :destroy
  has_many :companies, :through => :companyevents
  has_many :students, :through => :timeslots
  has_many :appointments, :through => :timeslots
  validates_uniqueness_of :name
  validates :name, :max_students, :event_date, :start_time, :end_time, :timeslot_duration, presence: true
  
	def self.as_csv(options = {})
	  #appointment table
	  CSV.generate(options) do |csv|
	  	column_names=Appointment.column_names
	  	csv << ["Appointment Table"]
	  	csv << column_names
		  
		  companies=nil
		  students=nil
		  all.each do |event|
		    appointments=Appointment.where( section: event.name )
		    appointments.each do |appointment|
		      csv << appointment.attributes.values_at(*column_names)
		      companies=Company.where( name: appointment.company ) if companies.nil?
		      companies=companies+Company.where( name: appointment.company )
		      students=Student.where( name: appointment.student ) if students.nil?
		      students=students+Student.where( name: appointment.student )
		    end
		  end
	  
	    #company table
	    if defined? companies
	      column_names=Company.column_names-["rep_1","rep_2","rep_3","rep_4","rep_5","rep_6"]
	      csv << [""]
	      csv << ["Company Table"]
	      csv << column_names
		    companies.uniq.each do |company|
		      csv << company.attributes.values_at(*column_names)
		    end
	    end
	    #student table
	    if defined? students
	      column_names=Student.column_names-["edithash"]
	      csv << [""]
	      csv << ["Student Table"]
	      csv << column_names
		    students.uniq.each do |student|
		      csv << student.attributes.values_at(*column_names)
		    end
		  end
	  end
	end
end

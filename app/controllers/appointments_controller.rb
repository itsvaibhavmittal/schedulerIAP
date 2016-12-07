class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  before_filter :authorize, only: [:index, :destroy, :new, :show], :except => :new_session_path
  # GET /appointments
  # GET /appointments.json
  def index
    # Sort appointments by section, then by timeslot
    @appointments = Appointment.all.order(:section, :time_slot) 
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        # Standard rails behavior. Save appointment and redirect to /appointments/id
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' } 
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        # Standard rails behavior. Update appointment with new parameters and redirect to /appointments/id
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    # Standard Rails behavior. Delete appointment with given id.
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Custom helper method to generate appointments
  helper_method :generate 

  def generate
    @studentfinish = [] 
    @errormessage = ["Error timeslot Below:"] 
    Appointment.delete_all

    events = Event.all 

    # Match each event
    events.each do |event|
      matchappsection(event)
    end

    flag = 0
    puts 'check if all student finish'

    #Throw flags for each student that wasn't able to finish
    print @studentfinish
    @studentfinish.each do |x|
      if x == true
        flag = 1;

      end
    end

    # Check all flags and flash appropriate notice
    if flag == 0
      redirect_to appointments_url, notice: 'Appointment was successfully generated.'
    else
      redirect_to appointments_url, notice: 'Appointment was successfully generated, however lack of company, some student failed, check your company status'
      flash[:notice] = @errormessage
    end
  end


  ################################################################
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(:section, :time_slot, :company, :student, :UIN)
  end

  ###############################################################

  # This function splits the event into timeslots and calls matchapp on each appropriated slot.
  def matchappsection(event)
    slots = event.timeslots # Grab the event's timeslots
    puts 'print time slot'
    puts slots

    # For each slot, match an appropriate appointment.
    slots.each do |timeslot|
      puts 'current select'
      puts timeslot
      puts ' '
      matchapp(timeslot, event)
    end
  end


  ###############################################################

  # This function matches a student and company for an appointment in the given timeslot for the given event
  def matchapp(timeslot, event)

    # Grab list of students signed up for the given timeslot
    @students = timeslot.students.collect {|item| [item.name, item.UIN, item.email, item.US_Citizen, item.degree, item.position_type]}

    # Grab list of companies signed up for the given timeslot
    event_companies = event.companyevents.where("representatives > 0").collect {|item| [item.company_id, item.representatives]}

    # Initialize lists for each type of company membership
    @companyplat = {}
    @companygold = {}
    @companysilver = {}
    @companybronze = {}

    # Sort companies into respective lists
    event_companies.each do |item|
      company = Company.find(item[0])
      if(company.sponsor_level == 'Platinum')
        @companyplat[company] = item[1]
      elsif(company.sponsor_level == 'Gold')
        @companygold[company] = item[1]
      elsif(company.sponsor_level == 'Silver')
        @companysilver[company] = item[1]
      elsif(company.sponsor_level == 'Bronze')
        @companybronze[company] = item[1]
      end
    end

    # Match companies to appointments based on priority of membership
    if @companyplat.length>0 && @students.length>0
      matchappoint(timeslot, event, @companyplat)
    end

    if @companygold.length>0 && @students.length>0
      matchappoint(timeslot, event, @companygold)
    end

    if @companysilver.length>0 && @students.length>0
      matchappoint(timeslot, event, @companysilver)
    end

    if @companybronze.length>0 && @students.length>0
      matchappoint(timeslot, event, @companybronze)
    end

    # Merge companies not paired.
    @comremain = {}
    @comremain.merge!(@companyplat).merge!(@companygold).merge!(@companysilver).merge!(@companybronze)

    @comremain.delete_if{|_,x| !x.nil? and x<=0}

    # Try to match remaining companies
    if @comremain.length>0 && @students.length>0
      matchappointwithout(timeslot, event, @comremain)
    end

    finish = @students.length>0

    # Log remaining students/time slots?
    puts @students.length
    if @students.length > 0
      error = "#{event.name}"+ ':  '+ "#{timeslot.start_time.strftime("%I:%M%p")}" + '-' + "#{timeslot.end_time.strftime("%I:%M%p")}"
      #error = arg
      @errormessage << error
    end

    @studentfinish << finish
  end


  ##############################################################

  # Match student with remaining compaines/timeslots
  def matchappointwithout(timeslot, event, companies)
    stuuin=[];
    totalrep = 0;

    # Parse through companies and count up the total number of representatives
    companies.each do |com, representatives|
      totalrep += representatives
    end

    # Match each student with rep and set up the corresponding appointment
    while @students.length > 0 && totalrep> 0 do
      @students.each do |student|
        companies.each do |item, representatives|

          if representatives > 0
            appointment = Appointment.new
            getone = student
            appointment.section = event.name
            appointment.time_slot = timeslot.start_time.strftime("%I:%M%p") + "-" + timeslot.end_time.strftime("%I:%M%p")
            appointment.company = item.name
            appointment.student = getone[0]
            appointment.UIN = getone[1]
            stuuin = stuuin << getone[1]
            representatives -= 1
            companies[item] = representatives
            totalrep-=1
            appointment.save
            break
          end
        end
      end
      stuuin.each do |uin|
        @students.delete_if {|x| x[1]==uin}
      end
    end

  end

  ###############################################################

  # Standard algorithm for matching students to companies. 
  def matchappoint(timeslot, event, companies)
    stuuin=[];
    @students.each do |student|
      student_scheduled = false
      for comp_degree_count in 1..3
        companies.each do |item, representatives|

          usif= item.citizenship=="US Citizen Only"? true:false
          conjobtype = item.job_type == student[5] || item.job_type == 'Any' || item.job_type == nil
          condegree = (item.student_level.length == comp_degree_count) && (item.student_level.include? student[4] || item.student_level.nil? || item.student_level.empty?)
          concitizen = usif == student[3] || usif == false || usif == nil

          if (representatives > 0 && conjobtype && condegree && concitizen)
            getone = student

            appointment = Appointment.new
            appointment.section = event.name
            appointment.time_slot = timeslot.start_time.strftime("%I:%M%p") + "-" + timeslot.end_time.strftime("%I:%M%p")
            appointment.company = item.name
            appointment.student = getone[0]
            appointment.UIN = getone[1]
            stuuin = stuuin << getone[1]
            representatives-=1
            companies[item] = representatives
            appointment.save
            student_scheduled = true
            break
          end
        end
        if (student_scheduled == true)
          break
        end

      end
    end

    stuuin.each do |uin|
      @students.delete_if {|x| x[1]==uin}
    end
  end
  ################################################################
end
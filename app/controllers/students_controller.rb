class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  # Before these actions (show, edit, update, and destroy) are run
  #   :set_student will run

  #<><><><>!!!!!!!!!!!! Comment this out for rspec !!!!!!!!!!!!!!!  
  before_filter :authorize, only: [:destroy, :index], :except => :new_session_path
  
  # Set flash to html safe when needed, allows links in flash
  before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }

  $stu_slot = Hash.new([])
  $students = Student.all.order(:UIN)
  $selected_slots = Hash.new([])
  $event_slots = Hash.new([])

  # GET /students
  # GET /students.json
  # Returns the list of all students and their respective timeslots
  def index
    @events = Event.where("for_student = true").pluck(:id,:name)
    $students = Student.all.order(:UIN)
    $students.each do |x|
      @arr = Hash.new([])
      # evaluate timeslots
      @tslots = x.timeslots
      @events.each do |ev|
        @check = FALSE
        @tslots.each do |t|
          if(t.event_id == ev[0])
            @arr[ev[1]] = (t.start_time.strftime("%I:%M%p") + "-" + t.end_time.strftime("%I:%M%p"))
            @check = TRUE
            break
          end
        end
        if(@check == FALSE)
          @arr[ev[1]] = ("Not Attend")
        end
      end
      $stu_slot[x.id] = @arr
    end
  end

  # GET /students/1
  # GET /students/1.json
  # Returns a single student as well as information
  #   like email and events attending
  def show
    # Verify login
    unless log_in? || cus_indentify(get_id)
      flash[:danger] = "Please Log in!"
      redirect_to new_session_path
    end
    
    @events = Event.where("for_student = true").pluck(:id,:name)
    $students = Student.all.order(:UIN)
    $students.each do |x|
      @arr = Hash.new([])
      # Select correct timeslots
      @tslots = x.timeslots
      @events.each do |ev|
        @check = FALSE
        @tslots.each do |t|
          if(t.event_id == ev[0])
            @arr[ev[1]] = (t.start_time.strftime("%I:%M%p") + "-" + t.end_time.strftime("%I:%M%p"))
            @check = TRUE
            break
          end
        end
        if(@check == FALSE)
          @arr[ev[1]] = ("Not Attend")
        end
      end
      $stu_slot[x.id] = @arr
    end
  end

  # GET /students/new
  # View where a new student can be created
  #   Calls create to actually create student
  def new
    @logged_in = log_in?
    @event_details = Event.where("for_student = true").pluck(:id, :name, :event_date, :start_time, :end_time, :editable)
    @student = Student.new
    
    @event_slot = Hash.new([])
    
    #List Events
    @events = Event.where("for_student = true").pluck(:id)
    @events.each do |id|
      @event, @event_slot = set_menu(id)
      $selected_slots[id] = ""
      $event_slots[id] = @event_slot
    end
  end

  # GET /students/1/edit
  # View where student information can be updated
  #   Calls update to actually update student
  #   Security Risk: On disabled event, choice can be
  #     changed via manually editing the HTML's hidden input
  def edit
    @logged_in = log_in?
    correct_hash = correct_hash(@student.edithash, params[:edithash])
    # Verify login
    if log_in? || cus_indentify(get_id) || correct_hash
      @event_details = Event.where("for_student = true").pluck(:id, :name, :event_date, :start_time, :end_time, :editable)
      @events = Event.where("for_student = true").pluck(:id, :name)
      # Show Timeslots
      $selected_slots = []
      @student.timeslots.each do |x| 
        $selected_slots[x.event_id] = x.id
      end
      
      # Show Events
      @events = Event.where("for_student = true").pluck(:id)
      @events.each do |id|
        @event, @event_slot = set_menu(id)
        $event_slots[id] = @event_slot
      end

    else
      flash[:danger] = "Please Log in!"
      redirect_to new_session_path
    end
  end

  # POST /students
  # POST /students.json
  # New student is created based on parameters
  def create
    @student = Student.new(student_params)
    @event_details = Event.where("for_student = true").pluck(:id, :name, :event_date, :start_time, :end_time, :editable)
    
    # Set edithash
    if @student.edithash == nil
      @student.edithash = SecureRandom.urlsafe_base64
    end

    @events = Event.where("for_student = true").pluck(:id, :name)
    @events.each do |id,name|
      $selected_slots[id] = params[name]
    end
    
    @event_slots = Hash.new([])
    respond_to do |format|
      # Try to save new information
      if @student.save
        input_session(@student.id)
	      Timeslot.decrease_1(@student.id)

      	@events = Event.where("for_student = true").pluck(:id,:name)
      	@events.each do |id,name|
          temp1, temp2 = set_menu(id)
      	  if(params[name] != "0"  && !params[name].nil? && !params[name].empty?)
      	    @student.timeslots << Timeslot.find(params[name])
      	  end
        end

	      #@selected_slots.each { |k, v| puts "Key=#{k}, Value=#{v}"}
        
        # Show all students
        @events = Event.where("for_student = true").pluck(:id,:name)
        $students = Student.all.order(:UIN)
        $students.each do |x|
          @arr = Hash.new([])
          @tslots = x.timeslots
          @events.each do |ev|
            @check = FALSE
            # Nicely show all time slots
            @tslots.each do |t|
              if(t.event_id == ev[0])
                @arr[ev[1]] = (t.start_time.strftime("%I:%M%p") + "-" + t.end_time.strftime("%I:%M%p"))
                @check = TRUE
                break
              end
            end
            if(@check == FALSE)
              @arr[ev[1]] = ("Not Attend")
            end
          end
          $stu_slot[x.id] = @arr
        end

        # UserMailer.stu_reg(@student).deliver_now

        format.html { redirect_to @student, notice: %Q[ Student was successfully created. #{view_context.link_to("Edit Link", get_edit_url(@student))} ], flash: { html_safe: true } }
        format.json { render :show, status: :created, location: @student }
      else
      	@events = Event.where("for_student = true").pluck(:id)
      	@events.each do |id|
          @event, @event_slot = set_menu(id)
      	  @event_slots[id] = @event_slot
        end
      
        flash[:notice] = @student.errors.full_messages
        format.html { render :new } 
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  # Student is updated with new information
  def update
    respond_to do |format|
      @event_details = Event.where("for_student = true").pluck(:id, :name, :event_date, :start_time, :end_time, :editable)
      @events = Event.where("for_student = true").pluck(:id, :name)
      @events.each do |id,name|
        $selected_slots[id] = params[name]
      end
    
      # When updating, temporarily release timeslots
    	Timeslot.increase_1(@student.id)
    	@student.timeslots = []
    	@events = Event.where("for_student = true").pluck(:name)
    	@events.each do |name|
      	if(params[name] != "0"  && !params[name].nil? && !params[name].empty?)
      	    @student.timeslots << Timeslot.find(params[name])
      	end
      end
      
      if @student.edithash == nil
        @student.edithash = SecureRandom.urlsafe_base64
      end
      
      # Ensure that the student was updated
      if @student.update(student_params)
        # UserMailer.stu_reg(@student).deliver_now
	      Timeslot.decrease_1(@student.id)
        
        if not (log_in? && cus_indentify(get_id))
          input_session(@student.id)
        end
        format.html { redirect_to @student, notice: %Q[ Entry was successfully updated. #{view_context.link_to("Edit Link", get_edit_url(@student))} ], flash: { html_safe: true } }
        format.json { render :show, status: :ok, location: @student }
      else
      	@events = Event.where("for_student = true").pluck(:id,:name)
      	@events.each do |id,name|
          temp1, temp2 = set_menu(id)
      	  Timeslot.decrease_1_id(temp1, @student.id, name)
        end
        
        flash[:notice] = @student.errors.full_messages
        format.html { redirect_to edit_student_path}
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  # Deletes the current student
  def destroy
    @student.destroy
    respond_to do |format|
      # UserMailer.stu_del(@student).deliver_now
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Creates drop down menus with all time slots
    def set_menu(arg)
      result_slots= Timeslot.where("event_id = ? AND stunum > 0", arg).collect{|item| [item.id, item.start_time, item.end_time, item.stunum]}
      slots = Hash.new([])
      slots['Not Attend'] = 0

      result_slots.each do |item|
        slots[item[1].strftime("%I:%M%p") + "-" + item[2].strftime("%I:%M%p")] = item[0]
      end
	    slots  = slots.sort
      return result_slots, slots
    end

    # Use callbacks to share common setup or constraints between actions.
    def get_id
      params[:id]
    end
  
    # Stores student in variable
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :UIN, :email, :US_Citizen, :degree, :position_type, :Mock_1, :edithash)
    end
    
    # Get the non-login student edit link
  	def get_edit_url(student)
  		uri = URI.parse(edit_student_path(student))
  		uri.query = URI.encode_www_form( {'edithash' => student.edithash} )
  		uri.to_s
  	end
  	
  	# Check that edithash is correct
  	def correct_hash(student_hash, test_hash)
  		student_hash == test_hash
  	end
end
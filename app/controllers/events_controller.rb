class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
 #<><><><>!!!!!!!!!!!! Comment this out for rspec !!!!!!!!!!!!!!!  

  before_filter :authorize, only: [:index, :destroy, :new, :show], :except => :new_session_path
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @event_slots = get_timeslots(@events)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @events = [@event]
    @event_slots = get_timeslots(@events)
  end

  # GET /events/new
  def new
    @event = Event.new
    @unedit = false
    @button_value ="Create"
  end

  # GET /events/1/edit
  def edit
    @unedit = true
    @button_value ="Edit"
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    date1 = @event.event_date
    @event.start_time = @event.start_time.change(day:date1.day, year:date1.year, month:date1.month)
    @event.end_time = @event.end_time.change(day:date1.day, year:date1.year, month:date1.month)

    respond_to do |format|
      if @event.save
        timeslot_start_time = @event.start_time
        timeslot_end_time = timeslot_start_time.advance(minutes: @event.timeslot_duration)
        while(timeslot_end_time <= @event.end_time)
          @timeslot = @event.timeslots.create(:start_time => timeslot_start_time, :end_time => timeslot_end_time, :stunum => @event.max_students)
          timeslot_start_time = timeslot_end_time
          timeslot_end_time = timeslot_start_time.advance(minutes: @event.timeslot_duration)
        end

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def get_timeslots(events)
    event_slots = Hash.new
    events.each do |event|
      timeslots = Timeslot.all.where(event_id: event.id)
      event_slots[event.id]=[]
      timeslots.each do |slot|
        event_slots[event.id] << slot.start_time.strftime("%I:%M%p") + "-" + slot.end_time.strftime("%I:%M%p")
      end
    end
    event_slots
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :event_date, :start_time, :end_time, :for_student, :max_students, :timeslot_duration)
  end
end


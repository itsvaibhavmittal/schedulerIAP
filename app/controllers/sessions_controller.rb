class SessionsController < ApplicationController

  before_filter :authorize, only: [:index, :destroy, :show], :except => :new_session_path
  
  # Set flash to html safe when needed, allows links in flash
  before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }

  ## Login page
  def new
  end

  ## Empty page with links to the rest of the views
  def index
  end

  ## Login actions
  def create
    useradd = Useradd.find_by(email: params[:session][:email].downcase)

    # Login is successful
    if useradd && useradd.authenticate(params[:session][:password])
      session[:useradd_id] = useradd.id
      flash[:notice] = "Weclome administrator : #{useradd.name}"
      redirect_to sessions_url
    else # Login is not successful
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
      #redirect_to new_session_path
    end
  end

  ## Logout function
  def del
        log_out
        redirect_to new_session_path, notice: 'Successfully Log Out!'
  end
end





# class SessionsController < ApplicationController
#   before_action :set_session, only: [:show, :edit, :update, :destroy]

#   # GET /sessions
#   # GET /sessions.json
#   def index
#     @sessions = Session.all
#   end

#   # GET /sessions/1
#   # GET /sessions/1.json
#   def show
#   end

#   # GET /sessions/new
#   def new
#     @session = Session.new
#   end

#   # GET /sessions/1/edit
#   def edit
#   end

#   # POST /sessions
#   # POST /sessions.json
#   def create
#     @session = Session.new(session_params)

#     respond_to do |format|
#       if @session.save
#         format.html { redirect_to @session, notice: 'Session was successfully created.' }
#         format.json { render :show, status: :created, location: @session }
#       else
#         format.html { render :new }
#         format.json { render json: @session.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /sessions/1
#   # PATCH/PUT /sessions/1.json
#   def update
#     respond_to do |format|
#       if @session.update(session_params)
#         format.html { redirect_to @session, notice: 'Session was successfully updated.' }
#         format.json { render :show, status: :ok, location: @session }
#       else
#         format.html { render :edit }
#         format.json { render json: @session.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /sessions/1
#   # DELETE /sessions/1.json
#   def destroy
#     @session.destroy
#     respond_to do |format|
#       format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_session
#       @session = Session.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def session_params
#       params[:session]
#     end
# end

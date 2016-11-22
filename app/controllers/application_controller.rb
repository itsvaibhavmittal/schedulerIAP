class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  def authorize
  	unless session[:useradd_id]
  		flash[:danger] = "Please log in"
  		redirect_to new_session_path
  	end
  end

  def log_in?
  	session[:useradd_id]
  end

	def input_session(arg)
      session[:stu_id] = arg
    end

  def cus_indentify(arg)
      session[:stu_id].to_s==arg
  end

  def log_out
    session[:useradd_id] = nil
  end

end

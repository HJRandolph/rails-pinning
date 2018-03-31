class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  helper_method :current_user
  
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def require_login
		if !logged_in?
			redirect_to :login
		end
    end
    
  def logged_in?
  	!current_user.nil? && !current_user.id.nil?
  end
  helper_method :logged_in?
  	    
 # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end

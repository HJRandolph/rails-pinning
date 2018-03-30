module ApplicationHelper
  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end
  
  def correct_user
    @correct_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
  	!current_user.nil? && !current_user.id.nil?
  end

end

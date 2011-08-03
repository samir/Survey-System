require "application_responder"
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :authorize_access, :logged_in?

  self.responder = ApplicationResponder
  respond_to :html

  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  def authorize_access
    if !logged_in?
      redirect_to login_path, :notice => "You need to log in to access this page"
    end
  end
  
  def logged_in?
    !current_user.nil?
  end

end

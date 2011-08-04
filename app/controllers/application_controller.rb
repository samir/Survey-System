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

  def status_watch(object)
    if current_user.id != object.id and current_user.watching.include? object.id
      @text = "Unwatch"
      @class = "on"
    else
      @text = "Watch"
      @class = nil
    end
  end

end

class UsersController < ApplicationController

  before_filter :authorize_access, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.authenticate(params[:password])
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, :notice => "Signed up and logged in!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def watchers
    @watchers = Watcher.joins(:survey, :user).where("surveys.user_id = ?", current_user.id).group("watchers.user_id")
  end

end
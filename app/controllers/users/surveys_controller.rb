class Users::SurveysController < ApplicationController
  def show
    @survey = Survey.where(:is_public => true, :user_id => params[:user_id], :id => params[:id]).first
    # render :nothing => true
    render :template => 'surveys/show'
    # render :controller => "users/surveys#show"
  end
end
class SurveysController < ApplicationController
  before_filter :authorize_access, :except => [:latest, :public]
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def not_found(exception = nil)
    @exception = exception
    render "not_found", :status => 404
  end

  # My Surveys
  def index
    @surveys = Survey.where(:user_id => current_user.id)
  end
  
  # Show survey
  def show
    @survey = Survey.find(params[:id])
    if current_user.id != params[:id] and current_user.watching.include? @survey.id
      @text = "Unwatch"
      @class = "on"
    else
      @text = "Watch"
      @class = nil
    end
  end
  
  def new
    @survey = Survey.new
    @survey.user = current_user
    2.times do
      question = @survey.questions.build
      4.times { question.answers.build }
    end
  end
  
  def create
    @survey = Survey.new(params[:survey])
    @survey.user = current_user
    @survey.save
    respond_with @survey
  end
  
  def edit
    @survey = Survey.find(params[:id])
  end
  
  def update
    @survey = Survey.find(params[:id])
    @survey.update_attributes(params[:survey])
    respond_with @survey
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    respond_with @survey
  end
  
  def watching
    @surveys = Survey.joins(:watchers).where("watchers.user_id = ?", current_user.id)
  end

  def latest
    @last_days = params[:last].to_i == 0 ? 7 : params[:last].to_i
    @surveys = Survey.where("is_public = ? AND created_at >= ?", true, @last_days.days.ago).order("created_at DESC")
  end

  def public
    @surveys = Survey.where(:is_public => true)
  end
  
  def set_watching
    if request.xhr?
      
      @survey_id = params[:id].to_i
      u = User.find(current_user.id)
      
      if u.watching.include? @survey_id
        # Is watching
        Watcher.where("user_id = ? AND survey_id = ?", current_user.id, @survey_id).each { |x| Watcher.destroy(x)}
        @text = "Watch"
        @status = 1
      else
        # Not watching yet
        Watcher.create!({:user_id => current_user.id, :survey_id => @survey_id})
        @text = "Unwatch"
        @status = 0
      end
      
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_path
    end
  end
end
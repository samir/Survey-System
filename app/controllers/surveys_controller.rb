class SurveysController < ApplicationController
  before_filter :authorize_access, :except => [:latest, :public]

  def index
    @surveys = Survey.where(:user_id => current_user.id)
  end
  
  def show
    @survey = Survey.find(params[:id])
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
    if @survey.save
      flash[:notice] = "Successfully created survey."
      redirect_to @survey
    else
      render :action => 'new'
    end
  end
  
  def edit
    @survey = Survey.find(params[:id])
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Successfully destroyed survey."
    redirect_to surveys_url
  end
  
  def watching
    @surveys = Survey.where(:user_id => current_user.id)
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
      
      # @field_name = params[:field_name]
      # @id = params[:id]
      # 
      # p = params[:model_name].underscore.camelize.constantize.find_by_id(@id)
      # p[@field_name] = !p[@field_name]
      # p.save!
      # 
      # @new_status = p[@field_name].to_s
      @text = 'Unwatch'
      @status = 0
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_path
    end
  end
end
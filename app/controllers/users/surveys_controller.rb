class Users::SurveysController < ApplicationController

  def show
    @survey = Survey.where(:is_active => true, :is_public => true, :user_id => params[:user_id], :id => params[:id]).first
    status_watch(@survey)
    render :template => 'surveys/show'
  end

  def answer
    @survey = Survey.where(:is_active => true, :is_public => true, :user_id => params[:user_id], :id => params[:id].to_i).first
    
    @user_answer = UserAnswer.select("answers.question_id, answers.content").joins(:answer).where(:user_id => current_user.id, :survey_id => params[:id].to_i)

    if params[:answer] and params[:answer][:action] == 'post'
      params[:answer][:options].each do |item|
        UserAnswer.create({:user_id => current_user.id, :survey_id => params[:id].to_i, :question_id => item[0].to_i, :answer_id => item[1].to_i})
        flash[:notice] = "Your answers are saved successfully! Thank you!"
      end unless !@user_answer.empty?
    end
  end

end
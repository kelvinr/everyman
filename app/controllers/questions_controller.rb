class QuestionsController < ApplicationController
  before_action :require_user

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params.merge!(user: current_user))
    
    if @question.save
      flash[:success] = "Your question has been submitted."
      redirect_to questions_path
    else
      render :new
    end
  end

  private

    def question_params
      params.require(:question).permit(:question, :additional_info)
    end
end

class QuestionsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :get_question, only: [:edit, :update]
  before_action -> { correct_user(@question) }, only: [:edit, :update]

  def index
    @questions = Question.all.order(:created_at).reverse_order
  end

  def show
    @question = Question.find(params[:id])
    @comment = Comment.new
  end

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

  def update
    if @question.update(question_params)
      flash[:success] = "Your question has been updated."
      redirect_to questions_path
    else
      render :edit
    end
  end

  private

    def question_params
      params.require(:question).permit(:question, :additional_info)
    end

    def get_question
      @question = current_user.questions.find_by(id: params[:id])
    end
end

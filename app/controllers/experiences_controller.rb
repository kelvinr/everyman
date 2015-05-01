class ExperiencesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :get_experience, only: [:edit, :update]

  def index
    @experiences = Experience.all
  end

  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params.merge!(user: current_user))

    if @experience.save
      flash[:success] = "Your experience has been posted."
      redirect_to experiences_path
    else
      render :new
    end
  end

  def update
    if @experience.update(experience_params)
      flash[:success] = "Your post has been update."
      redirect_to experiences_path
    else
      render :new
    end
  end

  private

    def experience_params
      params.require(:experience).permit(:title, :body)
    end

    def get_experience
      @experience = Experience.find_by(user: current_user)
    end
end

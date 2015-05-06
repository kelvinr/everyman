class SchedulesController < ApplicationController
  before_action :require_user
  before_action :get_schedule, only: [:edit, :update]
  before_action -> { correct_user(@schedule) }, only: [:edit, :update]

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params.merge!(user_id: current_user.id))

    if @schedule.save
      flash[:success] = "Your schedule has been created."
      redirect_to @schedule.user
    else
      render :new
    end
  end

  def update
    if @schedule.update(schedule_params)
      flash[:success] = "Your schedule has been updated."
      redirect_to @schedule.user
    else
      render :edit
    end
  end

  private

    def schedule_params
      params.require(:schedule).permit!
    end

    def get_schedule
      @schedule = current_user.schedule
    end
end

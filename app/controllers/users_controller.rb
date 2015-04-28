class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Thanks for joining! Welcome and enjoy."
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :phone_number, :password, :password_confirmation)
    end
end

class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:success] = "You are now logged in."
      redirect_back_or user
    else
      flash.now[:danger] = "Incorrect username or password."
      render :new
    end
  end

  def destroy
    if logged_in?
      session[:user_id] = nil
      flash[:info] = "You have logged out."
      redirect_to root_path
    end
  end
end

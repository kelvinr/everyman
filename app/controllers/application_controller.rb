class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !!current_user
  end

  def is_logged_in
    redirect_to home_path if current_user
  end

  def require_user
    unless logged_in?
      store_location
      flash[:danger] = "You must be logged in to do that!"
      redirect_to login_path
    end
  end

  def access_denied
    flash[:danger] = "You aren't allowed to do that!"
    redirect_to root_path
  end

  def correct_user(obj)
    access_denied unless !obj.nil? && obj.user == current_user
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def redirect_back_or(default)
    redirect_to session[:forwarding_url] || default
    session.delete(:forwarding_url)
  end
end

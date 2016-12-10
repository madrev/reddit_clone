class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def logout
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_unless_logged_in
    redirect_to new_session_url unless logged_in?
  end



end

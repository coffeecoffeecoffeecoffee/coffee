class ApplicationController < ActionController::Base
  include Authenticable
  include Pundit

  protect_from_forgery with: :exception

  helper_method :current_user

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    reset_session
  end
end

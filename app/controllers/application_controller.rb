class ApplicationController < ActionController::Base
  include Authenticable

  protect_from_forgery with: :exception

  def current_user_decorated
    return nil unless current_user

    current_user.decorate
  end
  helper_method :current_user_decorated

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    reset_session
  end
end

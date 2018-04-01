class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_with_omniauth(auth)
    log_in(user)
    redirect_to :root
  end

  def destroy
    log_out
    redirect_to :root
  end
end

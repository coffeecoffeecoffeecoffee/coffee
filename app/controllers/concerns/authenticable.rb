module Authenticable
  extend ActiveSupport::Concern

  included do
    def current_user
      @current_user || User.find_by(id: session[:user_id])
    end
  end
end

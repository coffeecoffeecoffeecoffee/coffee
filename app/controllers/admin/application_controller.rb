module Admin
  class ApplicationController < Administrate::ApplicationController
    include Authenticable

    before_action :authenticate_admin

    def authenticate_admin
      redirect_to :root unless current_user.superadmin?
    end
  end
end

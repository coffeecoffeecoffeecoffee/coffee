module Admin
  class EventsController < Admin::ApplicationController
    before_action :default_params

    private

    # Change default sort order of events
    # https://github.com/thoughtbot/administrate/issues/442#issuecomment-439209910
    def default_params
      resource_params = params.fetch(resource_name, {})
      order = resource_params.fetch(:order, "start_at")
      direction = resource_params.fetch(:direction, "desc")
      params[resource_name] = resource_params.merge(order: order, direction: direction)
    end
  end
end

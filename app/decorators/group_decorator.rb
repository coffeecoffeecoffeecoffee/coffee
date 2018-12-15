class GroupDecorator < ApplicationDecorator
  delegate_all

  def image_url
    event = object.events.order(:created_at).first
    return nil if event.nil?

    event.decorate.image_url
  end
end

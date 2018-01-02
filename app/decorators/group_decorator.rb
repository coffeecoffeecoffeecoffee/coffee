class GroupDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.name} #{object.emoji}"
  end
end

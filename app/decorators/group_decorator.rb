class GroupDecorator < ApplicationDecorator
  delegate_all

  def name_with_emoji
    "#{object.emoji} #{object.name}"
  end
end

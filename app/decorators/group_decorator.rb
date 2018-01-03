class GroupDecorator < ApplicationDecorator
  delegate_all

  def name_with_emoji
    "#{object.name} #{object.emoji}"
  end
end

class GroupDecorator < ApplicationDecorator
  def name
    "#{object.name} #{object.emoji}"
  end
end

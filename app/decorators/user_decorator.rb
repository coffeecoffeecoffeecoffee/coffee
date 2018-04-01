class UserDecorator < ApplicationDecorator
  delegate_all

  def avatar_url
    "#{twitter_url}/profile_image?size=original"
  end

  private

  def twitter_url
    "https://twitter.com/#{object.twitter}"
  end
end

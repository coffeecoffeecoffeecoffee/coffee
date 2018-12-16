module AuthenticationHelper
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(twitter_auth_hash_for_user(user))

    visit root_path
    click_link "Sign in"
    expect(page).to have_text("Sign out")
  end

  def twitter_auth_hash_for_user(user)
    {
      provider: :twitter,
      info: {
        name: user.name,
        email: user.email,
        nickname: user.twitter
      }
    }
  end
end

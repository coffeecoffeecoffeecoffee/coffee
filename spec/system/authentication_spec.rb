require 'rails_helper'

describe 'Authentication' do
  describe 'signing in with Twitter' do
    context 'when successful' do
      context 'when the user does not exist' do
        it 'creates and logs in the user' do
          expect(User.count).to eq(0)
          expect(page).not_to have_css('.header__avatar')

          sign_in_as(build(:user))
          expect(User.count).to eq(1)
          expect(page).to have_css('.header__avatar')
        end
      end

      context 'when the user already exists' do
        it 'finds and logs in the user' do
          user = create(:user)

          sign_in_as(user)
          expect(User.count).to eq(1)
        end
      end
    end

    context 'when unsuccessful' do
      it 'redirects to root' do
        visit '/auth/failure'
        expect(page).to have_current_path(root_path)
      end
    end
  end

  describe 'signing out' do
    it 'signs the user out' do
      user = create(:user)

      sign_in_as(user)

      click_link 'Sign out'
      expect(page).to have_text('Sign in')
    end
  end
end

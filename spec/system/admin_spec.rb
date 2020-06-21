require "rails_helper"

describe "Admin" do
  describe "dashboard authentication" do
    it "allows superadmins to access" do
      user = create(:user, twitter: "jamescmartinez")
      sign_in_as(user)

      visit admin_root_path
      expect(page).to have_current_path(admin_root_path)
      expect(page).to have_text("New event")
    end

    it "does not allow non-superadmins to access, redirecting them home" do
      user = create(:user, twitter: "notjamescmartinez")
      sign_in_as(user)

      visit admin_root_path
      expect(page).to have_current_path(root_path)
    end
  end
end

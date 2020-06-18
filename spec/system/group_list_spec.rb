require "rails_helper"

describe "Group list" do
  it "shows a list of all active groups" do
    inactive_group = create(:inactive_event, group: create(:group, name: "Inactive")).group
    coffee_group = create(:event, group: create(:group, name: "Coffee")).group
    beer_group = create(:event, group: create(:group, name: "Beer")).group

    visit root_path

    click_link "Groups"

    expect(page).to have_current_path(groups_path)
    expect(page).to have_link("Inactive", href: group_path(inactive_group))
    expect(page).to have_link("Coffee", href: group_path(coffee_group))
    expect(page).to have_link("Beer", href: group_path(beer_group))
  end
end

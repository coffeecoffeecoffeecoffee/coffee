require "rails_helper"

describe "Group list" do
  it "shows a list of all active groups" do
    create(:inactive_event)
    coffee_group = create(:event, group: create(:group, name: "Coffee")).group
    beer_group = create(:event, group: create(:group, name: "Beer")).group

    visit root_path

    click_link "Groups"

    expect(page).to have_current_path(groups_path)
    expect(page).to have_link("Coffee", href: group_path(coffee_group))
    expect(page).to have_link("Beer", href: group_path(beer_group))
  end
end

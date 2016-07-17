require "rails_helper"

RSpec.feature "user sees data visualization" do
  scenario "user sees graduation graphs" do
    visit '/'

    click_on "District Graduation"

    expect(page).to have_content("Choose a district and school year to see its graduation data")
  end

  scenario "user sees demographic graphs" do
    visit '/'

    click_on "District Demographics"

    expect(page).to have_content("Choose a district and school year to see its demographic data")
  end
end

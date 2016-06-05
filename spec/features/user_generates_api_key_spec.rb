require "rails_helper"

RSpec.feature "visitor creates and accesses API Key" do
  scenario "new user generates key" do
    visit '/'
    click_on "Generate API Key"

    fill_in :user_email,                 with: "adrienne.domingus@gmail.com"
    fill_in :user_password,              with: "password"
    fill_in :user_password_confirmation, with: "password"

    click_on "Generate Key"

    expect(page).to have_content("Your API key is:")
    expect(page).to have_content("Welcome adrienne.domingus@gmail.com")
  end

  scenario "new user password confirmation does not match" do
    visit '/'
    click_on "Generate API Key"

    fill_in :user_email,                 with: "adrienne.domingus@gmail.com"
    fill_in :user_password,              with: "password"
    fill_in :user_password_confirmation, with: "password2"

    click_on "Generate Key"
    expect(page).to have_content("There was a problem with your request. Please make sure you entered a valid email that has not been used to generate an api key before, and that your passwords match")
  end

  scenario "existing user logs in" do
    user = User.create(email: "example@example.com", password: "password", api_key: "123abc")

    visit login_path
    fill_in :session_email, with: user.email
    fill_in :session_password, with: user.password
    within(".form") do
      click_on "Log In"
    end

    expect(page).to have_content("Welcome #{user.email}")
    expect(page).to have_content("Your API key is: 123abc")
  end

  scenario "existing user is not authenticated" do
    user = User.create(email: "example@example.com", password: "password", api_key: "123abc")

    visit login_path
    fill_in :session_email, with: user.email
    fill_in :session_password, with: "wrongpassword"
    within(".form") do
      click_on "Log In"
    end

    expect(page).to_not have_content("Welcome #{user.email}")
    expect(page).to_not have_content("Your API key is: 123abc")
    expect(page).to have_content("Your email and password combination is not recognized. Please try again.")
  end

  scenario "existing user logs out" do
    user = User.create(email: "example@example.com", password: "password", api_key: "123abc")

    visit login_path
    fill_in :session_email, with: user.email
    fill_in :session_password, with: user.password
    within(".form") do
      click_on "Log In"
    end

    expect(page).to have_content("Welcome #{user.email}")
    expect(page).to have_content("Your API key is: 123abc")

    click_on "Log Out"

    expect(page).to_not have_content("Welcome #{user.email}")
    expect(page).to_not have_content("Your API key is: 123abc")
    expect(page).to have_content("You have been logged out")
  end
end

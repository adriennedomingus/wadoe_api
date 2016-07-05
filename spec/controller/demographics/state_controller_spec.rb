require 'rails_helper'

RSpec.describe Api::V1::Demographics::StateController, type: :controller do
  it "returns data statewide" do
    user = User.create(email: "example@example.com", password: "password", api_key: "abc123")

    school_year, _ = create_district_and_demographic_data

    get :show, year: school_year.years, api_key: user.api_key, format: :json
    state_demographics = JSON.parse(response.body)

    expect(state_demographics["demographics"][0]["race ethnicity"]).to be_truthy
    expect(state_demographics["demographics"][1]["exceptional student services"]).to be_truthy
    expect(state_demographics["demographics"][2]["other"]).to be_truthy
    expect(state_demographics["demographics"][3]["gender"]).to be_truthy
  end
end

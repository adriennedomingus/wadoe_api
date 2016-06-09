require 'rails_helper'

RSpec.describe Api::V1::Graduation::DistrictsController, type: :controller do
  describe "GET show" do
    it "returns a specific districts demographic information" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      school_year, _, _, district = create_district_and_demographic_data

      get :show, slug: district.slug, year: school_year.years, api_key: user.api_key, format: :json
      district_demographics = JSON.parse(response.body)


      expect(district_demographics["graduation"]).to be_truthy
      expect(district_demographics["graduation"][1]["race ethnicity"]["asian"]["transferred_out"]).to be_truthy
      expect(response.code).to eq("200")
    end

    it "responds with error if school year doesn't exist" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      _, _, _, district = create_district_and_demographic_data

      get :show, slug: district.slug, year: "2014-15", api_key: user.api_key, format: :json

      expected_response = {
        message: "We do not have data for that school year. Please try another query.",
        status: 404
      }.to_json

      expect(response.body).to eq(expected_response)
      expect(response.code).to eq("404")
    end

    it "responds with error if school district doesn't exist" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      create_district_and_demographic_data

      get :show, slug: 'fake-school-district', year: "2015-16", api_key: user.api_key, format: :json

      expected_response = {
        message: "We do not have that school district in our system. Please try another query",
        status: 404
      }.to_json

      expect(response.body).to eq(expected_response)
      expect(response.code).to eq("404")
    end

    it "requires a valid API key" do
      school_year, _, _, district = create_district_and_demographic_data


      get :show, slug: district.slug, year: school_year.years, format: :json

      expected_response = { message: "Please include a valid API key with your request", status: 401 }.to_json

      expect(response.code).to eq("401")
      expect(expected_response).to eq(response.body)
    end
  end
end
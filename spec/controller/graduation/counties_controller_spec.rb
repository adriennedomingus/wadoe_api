require 'rails_helper'

RSpec.describe Api::V1::Graduation::CountiesController, type: :controller do
  describe "GET show" do
    it "returns a specific districts graduation statistics" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      school_year, county = create_district_and_demographic_data

      get :show, slug: county.slug, year: school_year.years, api_key: user.api_key, format: :json
      county_graduation = JSON.parse(response.body)

      expect(county_graduation["graduation"]).to be_truthy
      expect(county_graduation["graduation"][0]["race ethnicity"]["asian"]["transferred_out"]).to be_truthy
      expect(county_graduation["graduation"][1]["exceptional student services"]).to be_truthy
      expect(county_graduation["graduation"][4]["all"]).to be_truthy
      expect(county_graduation["graduation"][2]["other"]).to be_truthy
      expect(county_graduation["graduation"][3]["gender"]).to be_truthy
      expect(response.code).to eq("200")
    end

    it "returns a specific districts graduation statistics scoped by tag" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      school_year, county = create_district_and_demographic_data

      get :show, slug: county.slug, year: school_year.years, api_key: user.api_key, graduation_tag: "race ethnicity", format: :json
      district_demographics = JSON.parse(response.body)

      expect(district_demographics["graduation"]).to be_truthy
      expect(district_demographics["graduation"][0]["race ethnicity"]["asian"]["transferred_out"]).to be_truthy
      expect(district_demographics["graduation"][1]).to be_falsy
      expect(response.code).to eq("200")
    end

    it "responds with error if school year doesn't exist" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      _, county = create_district_and_demographic_data

      get :show, slug: county.slug, year: "2014-15", api_key: user.api_key, format: :json

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
        message: "We do not have that school district/county in our system. Please try another query",
        status: 404
      }.to_json

      expect(response.body).to eq(expected_response)
      expect(response.code).to eq("404")
    end

    it "responds with error if school district and school year don't exist" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      create_district_and_demographic_data

      get :show, slug: 'fake-school-district', year: "2012-13", api_key: user.api_key, format: :json

      expected_response = {
        message: "We do not have data for that school district/county or school year. Please try another query.",
        status: 404
      }.to_json

      expect(response.body).to eq(expected_response)
      expect(response.code).to eq("404")
    end

    it "requires a valid API key" do
      school_year, county = create_district_and_demographic_data


      get :show, slug: county.slug, year: school_year.years, format: :json

      expected_response = { message: "Please include a valid API key with your request", status: 401 }.to_json

      expect(response.code).to eq("401")
      expect(expected_response).to eq(response.body)
    end
  end

  describe "GET highest" do
    it "responds with x districts with highest cohort graduation rates" do
      school_year, county, county2, county3 = create_graduation_rates_for_multiple_counties
      User.create(email: "example@example.com", password: "password", api_key: "abc123")

      get :highest, identifier: 'female', year: school_year.years, top: 3, api_key: 'abc123', format: :json

      top_graduation_rates = JSON.parse(response.body)

      expect(top_graduation_rates.length).to eq(3)
      expect(top_graduation_rates[0]["county"]["name"]).to eq(county.name)
      expect(top_graduation_rates[1]["county"]["name"]).to eq(county2.name)
      expect(top_graduation_rates[2]["county"]["name"]).to eq(county3.name)
    end

    it "requires a valid API key" do
      school_year, _ = create_graduation_rates_for_multiple_counties

      get :highest, identifier: 'female', year: school_year.years, top: 3, format: :json

      expected_response = { message: "Please include a valid API key with your request", status: 401 }.to_json
      expect(response.code).to eq("401")
      expect(expected_response).to eq(response.body)
    end

    it "responds with overall data if identifier is not provided" do
      school_year, county, county2, county3 = create_graduation_rates_for_multiple_counties
      User.create(email: "example@example.com", password: "password", api_key: "abc123")

      get :highest, year: school_year.years, top: 3, api_key: 'abc123', format: :json

      top_graduation_rates = JSON.parse(response.body)

      expect(top_graduation_rates.length).to eq(3)
      expect(top_graduation_rates[0]["county"]["name"]).to eq(county.name)
      expect(top_graduation_rates[0]["graduation"][0]["all"]).to be_truthy
      expect(top_graduation_rates[1]["county"]["name"]).to eq(county2.name)
      expect(top_graduation_rates[1]["graduation"][0]["all"]).to be_truthy
      expect(top_graduation_rates[2]["county"]["name"]).to eq(county3.name)
      expect(top_graduation_rates[2]["graduation"][0]["all"]).to be_truthy
    end

    it "respoonds with an error if the school year doesn't exist" do
      User.create(email: "example@example.com", password: "password", api_key: "abc123")
      create_graduation_rates_for_multiple_districts

      get :highest, year: "2010-11", top: 3, api_key: 'abc123', format: :json

      expected_response = {
        message: "We do not have data for that school year. Please try another query.",
        status: 404
      }.to_json

      expect(response.body).to eq(expected_response)
      expect(response.code).to eq("404")
    end

    it "defaults to top ten if number is not provided" do
      school_year, _ = create_graduation_rates_for_multiple_districts
      User.create(email: "example@example.com", password: "password", api_key: "abc123")

      get :highest, identifier: 'female', year: school_year.years, api_key: 'abc123', format: :json

      top_graduation_rates = JSON.parse(response.body)
      #test data currently only contains 5 districts. Returns 10 in dev
      expect(top_graduation_rates.length).to eq(5)
    end
  end
end

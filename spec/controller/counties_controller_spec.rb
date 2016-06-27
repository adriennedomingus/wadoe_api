require 'rails_helper'

RSpec.describe Api::V1::CountiesController, type: :controller do
  describe "GET index" do
    it "returns all counties and their slugs" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      county_1 = County.create(name: "King", number: "17", slug: "king")
      educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
      District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county_1.id, slug: "auburn-school-district")
      District.create(name: "Issaquah School District", number: "17411", educational_service_district_id: educational_service_district.id, county_id: county_1.id, slug: "issaquah-school-district")
      county_2 = County.create(name: "Grays Harbor", number: "14", slug: "grays-harbor")
      District.create(name: "Wenatchee School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county_2.id, slug: "wenatchee-school-district")
      District.create(name: "Spokane School District", number: "17411", educational_service_district_id: educational_service_district.id, county_id: county_2.id, slug: "spokane-school-district")

      get :index, api_key: user.api_key, format: :json

      counties = JSON.parse(response.body)

      counties.each do |county|
        expect(county["name"]).to be_truthy
        expect(county["slug"]).to be_truthy
        expect(county["number"]).to be_truthy
        expect(county["districts"][0]["name"]).to be_truthy
        expect(county["districts"][1]["name"]).to be_truthy
        expect(county["districts"][0]["slug"]).to be_truthy
        expect(county["districts"][1]["slug"]).to be_truthy
        expect(county["districts"][0]["number"]).to be_truthy
        expect(county["districts"][1]["number"]).to be_truthy
      end

      expect(response.code).to eq("200")
    end

    it "requires a valid API key" do
      county = County.create(name: "King", number: "17", slug: "king")
      educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
      District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")

      get :index, format: :json

      expected_response = { message: "Please include a valid API key with your request", status: 401 }.to_json

      expect(response.code).to eq("401")
      expect(expected_response).to eq(response.body)
    end
  end
end

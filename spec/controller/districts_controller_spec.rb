require 'rails_helper'

RSpec.describe Api::V1::DistrictsController, type: :controller do
  describe "GET index" do
    it "returns all districts and their slugs" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      county = County.create(name: "King", number: "17", slug: "king")
      educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
      district1 = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
      district2 = District.create(name: "Issaquah School District", number: "17411", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "issaquah-school-district")

      get :index, api_key: user.api_key, format: :json

      districts = JSON.parse(response.body)

      result = [ { "name" => district1.name,
                    "slug" => district1.slug,
                    "number" => district1.number,
                    "educational_service_district" => {
                      "name" => educational_service_district.name,
                      "slug" => educational_service_district.slug,
                    },
                    "county" => {
                      "name" => county.name,
                      "slug" => county.slug
                    }
                  },
                  { "name" => district2.name,
                    "slug" => district2.slug,
                    "number" => district2.number,
                    "educational_service_district" => {
                      "name" => educational_service_district.name,
                      "slug" => educational_service_district.slug,
                    },
                    "county" => {
                      "name" => county.name,
                      "slug" => county.slug
                    }
                  }]

      expect(districts).to eq(result)
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

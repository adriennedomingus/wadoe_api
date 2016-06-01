require 'rails_helper'

RSpec.describe Api::V1::DistrictsController, type: :controller do
  describe "GET index" do
    it "returns all districts and their slugs" do
      c = County.create(name: "King", number: "17", slug: "king")
      esd = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
      d1 = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: esd.id, county_id: c.id, slug: "auburn-school-district")
      d2 = District.create(name: "Issaquah School District", number: "17411", educational_service_district_id: esd.id, county_id: c.id, slug: "issaquah-school-district")

      get :index, format: :json

      districts = JSON.parse(response.body)

      result = [ { "name" => d1.name,
                    "slug" => d1.slug,
                    "number" => d1.number,
                    "educational_service_district" => {
                      "name" => esd.name,
                      "slug" => esd.slug,
                    },
                    "county" => {
                      "name" => c.name,
                      "slug" => c.slug
                    }
                  },
                  { "name" => d2.name,
                    "slug" => d2.slug,
                    "number" => d2.number,
                    "educational_service_district" => {
                      "name" => esd.name,
                      "slug" => esd.slug,
                    },
                    "county" => {
                      "name" => c.name,
                      "slug" => c.slug
                    }
                  }]

      expect(districts).to eq(result)
    end
  end
end

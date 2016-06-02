require 'rails_helper'

RSpec.describe Api::V1::Demographics::DistrictsController, type: :controller do
  describe "GET show" do
    it "returns a specific districts demographic information" do
      sy, _, _, d, se, g, od, ess, re = create_district_and_data

      get :show, slug: d.slug, year: sy.years, format: :json
      district_demographics = JSON.parse(response.body)
      result = {
        "total" => se.total,
        "students_per_classroom_teacher" => se.students_per_classroom_teacher,
        "district" => {
          "name" => d.name,
          "slug" => d.slug,
          "number" => d.number,
        },
        "gender" => {
          "percent_male" => g.percent_male,
          "number_male" => g.number_male,
          "percent_female" => g.percent_female,
          "number_female" => g.number_female
        },
        "exceptional_student_service" => {
          "percent_special_education" => ess.percent_special_education,
          "number_special_education" => ess.number_special_education,
          "percent_504" => ess.percent_504,
          "number_504" => ess.number_504
        },
        "race_ethnicity" => {
          "percent_american_indian_or_alaskan_native" => re.percent_american_indian_or_alaskan_native,
          "number_american_indian_or_alaskan_native" => re.number_american_indian_or_alaskan_native,
          "percent_asian" => re.percent_asian,
          "number_asian" => re.number_asian,
          "percent_pacific_islander" => re.percent_pacific_islander,
          "number_pacific_islander" => re.number_pacific_islander,
          "percent_asian_pacific_islander" => re.percent_asian_pacific_islander,
          "number_asian_pacific_islander" => re.number_asian_pacific_islander,
          "percent_black" => re.percent_black,
          "number_black" => re.number_black,
          "percent_hispanic" => re.percent_hispanic,
          "number_hispanic" => re.number_hispanic,
          "percent_white" => re.percent_white,
          "number_white" => re.number_white,
          "percent_two_or_more" => re.percent_two_or_more,
          "number_two_or_more" => re.number_two_or_more},
        "other_demographic" => {
          "percent_migrant" => od.percent_migrant,
          "number_migrant" => od.number_migrant,
          "percent_transitional_bilingual" => od.percent_transitional_bilingual,
          "number_transitional_bilingual" => od.number_transitional_bilingual,
          "percent_frl" => od.percent_frl,
          "number_frl" => od.number_frl,
          "percent_foster_care" => od.percent_foster_care,
          "number_foster_care" => od.number_foster_care
        }
      }

      expect(district_demographics).to eq(result)
    end

    it "responds with error if school year doesn't exist" do
      _, _, _, d = create_district_and_data

      get :show, slug: d.slug, year: "2014-15", format: :json

      expected_response = {
        message: "We do not have data for that combination of school district and school year. Please try another query.",
        status: 400
      }.to_json

      expect(response.body).to eq(expected_response)
    end

    it "responds with error if school district doesn't exist" do
      create_district_and_data

      get :show, slug: 'fake-school-district', year: "2015-16", format: :json

      expected_response = {
        message: "We do not have data for that combination of school district and school year. Please try another query.",
        status: 400
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end

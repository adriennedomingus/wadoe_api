require 'rails_helper'

RSpec.describe Api::V1::Demographics::DistrictsController, type: :controller do
  describe "GET show" do
    it "returns a specific districts demographic information" do
      school_year, _, _, district, student_enrollment, gender, other_demographic, exceptional_student_service, race_ethnicity = create_district_and_data

      get :show, slug: district.slug, year: school_year.years, format: :json
      district_demographics = JSON.parse(response.body)
      result = {
        "total" => student_enrollment.total,
        "students_per_classroom_teacher" => student_enrollment.students_per_classroom_teacher,
        "district" => {
          "name" => district.name,
          "slug" => district.slug,
          "number" => district.number,
        },
        "gender" => {
          "percent_male" => gender.percent_male,
          "number_male" => gender.number_male,
          "percent_female" => gender.percent_female,
          "number_female" => gender.number_female
        },
        "exceptional_student_service" => {
          "percent_special_education" => exceptional_student_service.percent_special_education,
          "number_special_education" => exceptional_student_service.number_special_education,
          "percent_504" => exceptional_student_service.percent_504,
          "number_504" => exceptional_student_service.number_504
        },
        "race_ethnicity" => {
          "percent_american_indian_or_alaskan_native" => race_ethnicity.percent_american_indian_or_alaskan_native,
          "number_american_indian_or_alaskan_native" => race_ethnicity.number_american_indian_or_alaskan_native,
          "percent_asian" => race_ethnicity.percent_asian,
          "number_asian" => race_ethnicity.number_asian,
          "percent_pacific_islander" => race_ethnicity.percent_pacific_islander,
          "number_pacific_islander" => race_ethnicity.number_pacific_islander,
          "percent_asian_pacific_islander" => race_ethnicity.percent_asian_pacific_islander,
          "number_asian_pacific_islander" => race_ethnicity.number_asian_pacific_islander,
          "percent_black" => race_ethnicity.percent_black,
          "number_black" => race_ethnicity.number_black,
          "percent_hispanic" => race_ethnicity.percent_hispanic,
          "number_hispanic" => race_ethnicity.number_hispanic,
          "percent_white" => race_ethnicity.percent_white,
          "number_white" => race_ethnicity.number_white,
          "percent_two_or_more" => race_ethnicity.percent_two_or_more,
          "number_two_or_more" => race_ethnicity.number_two_or_more},
        "other_demographic" => {
          "percent_migrant" => other_demographic.percent_migrant,
          "number_migrant" => other_demographic.number_migrant,
          "percent_transitional_bilingual" => other_demographic.percent_transitional_bilingual,
          "number_transitional_bilingual" => other_demographic.number_transitional_bilingual,
          "percent_frl" => other_demographic.percent_frl,
          "number_frl" => other_demographic.number_frl,
          "percent_foster_care" => other_demographic.percent_foster_care,
          "number_foster_care" => other_demographic.number_foster_care
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

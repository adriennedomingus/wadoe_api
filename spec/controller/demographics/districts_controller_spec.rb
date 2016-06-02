require 'rails_helper'

RSpec.describe Api::V1::Demographics::DistrictsController, type: :controller do
  describe "GET show" do
    it "returns a specific districts demographic information" do
      sy = SchoolYear.create(years: "2015-2016")
      c = County.create(name: "King", number: "17", slug: "king")
      esd = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
      d = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: esd.id, county_id: c.id, slug: "auburn-school-district")
      se = StudentEnrollment.create(school_year_id: sy.id, total: 1378, students_per_classroom_teacher: 18, district_id: d.id)
      g = Gender.create(percent_male: 49, number_male: 73, percent_female: 51, number_female: 82, student_enrollment_id: se.id)
      od = OtherDemographic.create(percent_migrant: 2.42, number_migrant: 73, percent_transitional_bilingual: 14.83, number_transitional_bilingual: 37, percent_frl: 37.34, number_frl: 145, percent_foster_care: 2.04, number_foster_care: 31, student_enrollment_id: se.id)
      ess = ExceptionalStudentService.create(percent_special_education: 10, number_special_education: 181, percent_504: 7.56, number_504: 147, student_enrollment_id: se.id)
      re = RaceEthnicity.create(percent_american_indian_or_alaskan_native: 2.03, number_american_indian_or_alaskan_native: 28, percent_asian: 14.30, number_asian: 94, percent_pacific_islander: 2.32, number_pacific_islander: 83, percent_asian_pacific_islander: 8.32, number_asian_pacific_islander: 23, percent_black: 42.12, number_black: 123, percent_hispanic: 13.42, number_hispanic: 983, percent_white: 12, number_white: 193, percent_two_or_more: 12.3, number_two_or_more: 412, student_enrollment_id: se.id)

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
  end
end

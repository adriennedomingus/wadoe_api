require 'simplecov'
SimpleCov.start 'rails'

module SpecHelpers
  def create_district_and_data
    school_year = SchoolYear.create(years: "2015-16")
    county = County.create(name: "King", number: "17", slug: "king")
    educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
    district = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
    student_enrollment = StudentEnrollment.create(school_year_id: school_year.id, total: 1378, students_per_classroom_teacher: 18, district_id: district.id)
    gender = Gender.create(percent_male: 49, number_male: 73, percent_female: 51, number_female: 82, student_enrollment_id: student_enrollment.id)
    other_demographic = OtherDemographic.create(percent_migrant: 2.42,
                                 number_migrant: 73,
                                 percent_transitional_bilingual: 14.83,
                                 number_transitional_bilingual: 37,
                                 percent_frl: 37.34, number_frl: 145,
                                 percent_foster_care: 2.04,
                                 number_foster_care: 31,
                                 student_enrollment_id: student_enrollment.id)
    exceptional_student_service = ExceptionalStudentService.create(percent_special_education: 10,
                                                                   number_special_education: 181,
                                                                   percent_504: 7.56,
                                                                   number_504: 147,
                                                                   student_enrollment_id: student_enrollment.id)
    race_ethnicity = RaceEthnicity.create(percent_american_indian_or_alaskan_native: 2.03,
                              number_american_indian_or_alaskan_native: 28,
                              percent_asian: 14.30,
                              number_asian: 94,
                              percent_pacific_islander: 2.32,
                              number_pacific_islander: 83,
                              percent_asian_pacific_islander: 8.32,
                              number_asian_pacific_islander: 23,
                              percent_black: 42.12,
                              number_black: 123,
                              percent_hispanic: 13.42,
                              number_hispanic: 983,
                              percent_white: 12,
                              number_white: 193,
                              percent_two_or_more: 12.3,
                              number_two_or_more: 412,
                              student_enrollment_id: student_enrollment.id)
    [school_year, county, educational_service_district, district, student_enrollment, gender, other_demographic, exceptional_student_service, race_ethnicity]
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SpecHelpers
end

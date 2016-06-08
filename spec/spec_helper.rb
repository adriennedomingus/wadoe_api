require 'simplecov'
SimpleCov.start 'rails'

module SpecHelpers
  def create_district_and_data

    create_tags_and_identifiers
    school_year = SchoolYear.create(years: "2015-16")
    county = County.create(name: "King", number: "17", slug: "king")
    educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
    district = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
    student_enrollment = StudentEnrollment.create(total: 1378, students_per_classroom_teacher: 18)
    district_school_year = DistrictSchoolYear.create(ditrict_id: district.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    PopulationDemographic.create(number: 234,
                                percent: 49.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'female'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 276,
                                percent: 50.8,
                                student_identifier_id: StudentIdentifier.find_by(name: 'male'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 134,
                                percent: 14.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'american indian or alaskan native'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 362,
                                percent: 12.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'asian'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 12,
                                percent: 41.1,
                                student_identifier_id: StudentIdentifier.find_by(name: 'asian pacific islander'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 144,
                                percent: 13.4,
                                student_identifier_id: StudentIdentifier.find_by(name: 'black or african american'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 123,
                                percent: 45.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'hispanic or latino'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 34,
                                percent: 13.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'pacific islander'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 132,
                                percent: 12.8,
                                student_identifier_id: StudentIdentifier.find_by(name: 'two or more races'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 145,
                                percent: 54.5,
                                student_identifier_id: StudentIdentifier.find_by(name: 'white'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 16,
                                percent: 1.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'foster care'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 543,
                                percent: 84.5,
                                student_identifier_id: StudentIdentifier.find_by(name: 'free or reduced price lunch'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 45,
                                percent: 10.1,
                                student_identifier_id: StudentIdentifier.find_by(name: 'transitional bilingual'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 172,
                                percent: 1.7,
                                student_identifier_id: StudentIdentifier.find_by(name: 'title i migrant'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 124,
                                percent: 3.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'section 504'),
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 235,
                                percent: 10.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'special education'),
                                district_school_year_id: district_school_year.id,)
    [school_year, county, educational_service_district, district]
  end

  def create_tags_and_identifiers
    tags = ['race ethnicity', 'exceptional student services', 'other', 'gender', 'all']

    gender_identifiers = ['female', 'male']
    race_ethnicity_identifiers = ['american indian or alaskan native',
                                  'asian',
                                  'asian pacific islander',
                                  'black or african american',
                                  'hispanic or latino',
                                  'pacific islander',
                                  'two or more races',
                                  'white']
    other_identifiers = ['foster care',
                         'free or reduced price lunch',
                         'homeless',
                         'transitional bilingual',
                         'title i migrant']
    ess_identifiers = ['section 504',
                       'special education']

    tags.each do |tag|
      Tag.find_or_create_by(name: tag)
    end

    gender_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'gender')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    race_ethnicity_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'race ethnicity')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    other_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'other')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    ess_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'exceptional student services')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    all_tag = Tag.find_by(name: 'all')
    StudentIdentifier.find_or_create_by(name: 'all', tag_id: all_tag.id)
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

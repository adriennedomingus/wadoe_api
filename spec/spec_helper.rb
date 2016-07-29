require 'simplecov'
SimpleCov.start 'rails'

module SpecHelpers
  def create_district_and_demographic_data
    create_tags_and_identifiers
    school_year = SchoolYear.create(years: "2015-16")
    county = County.create(name: "King", number: "17", slug: "king")
    educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
    district = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
    student_enrollment = StudentEnrollment.create(total: 1378, students_per_classroom_teacher: 18)
    district_school_year = DistrictSchoolYear.create(district_id: district.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    county_school_year = CountySchoolYear.create(county_id: county.id, school_year_id: school_year.id)
    PopulationDemographic.create(number: 234,
                                percent: 49.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 276,
                                percent: 50.8,
                                student_identifier_id: StudentIdentifier.find_by(name: 'male').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 134,
                                percent: 14.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'american indian or alaskan native').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 362,
                                percent: 12.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'asian').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 12,
                                percent: 41.1,
                                student_identifier_id: StudentIdentifier.find_by(name: 'asian pacific islander').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 144,
                                percent: 13.4,
                                student_identifier_id: StudentIdentifier.find_by(name: 'black or african american').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 123,
                                percent: 45.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'hispanic or latino').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 34,
                                percent: 13.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'pacific islander').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 132,
                                percent: 12.8,
                                student_identifier_id: StudentIdentifier.find_by(name: 'two or more races').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 145,
                                percent: 54.5,
                                student_identifier_id: StudentIdentifier.find_by(name: 'white').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 16,
                                percent: 1.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'foster care').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 543,
                                percent: 84.5,
                                student_identifier_id: StudentIdentifier.find_by(name: 'free or reduced price lunch').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 45,
                                percent: 10.1,
                                student_identifier_id: StudentIdentifier.find_by(name: 'transitional bilingual').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 172,
                                percent: 1.7,
                                student_identifier_id: StudentIdentifier.find_by(name: 'title i migrant').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 124,
                                percent: 3.3,
                                student_identifier_id: StudentIdentifier.find_by(name: 'section 504').id,
                                district_school_year_id: district_school_year.id,)
    PopulationDemographic.create(number: 235,
                                percent: 10.2,
                                student_identifier_id: StudentIdentifier.find_by(name: 'special education').id,
                                district_school_year_id: district_school_year.id,)
                                dropout = Dropout.create(year_1: 34,
                                               year_2: 13,
                                               year_3: 60,
                                               year_4: 8)
                                FiveYearGraduationRate.create(began_9_in_wa: 234,
                                                            transferred_in: 49.2,
                                                            transferred_out: 49.2,
                                                            adjusted_cohort: 49.2,
                                                            graduates: 49.2,
                                                            continuing: 49.2,
                                                            adjusted_five_year_cohort_graduation_rate: 49.2,
                                                            cohort_dropout_rate: 49.2,
                                                            continuing_rate: 49.2,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 276,
                                                            transferred_in: 50.8,
                                                            transferred_out: 50.8,
                                                            adjusted_cohort: 50.8,
                                                            graduates: 50.8,
                                                            continuing: 50.8,
                                                            adjusted_five_year_cohort_graduation_rate: 50.8,
                                                            cohort_dropout_rate: 50.8,
                                                            continuing_rate: 50.8,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'male').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 134,
                                                            transferred_in: 14.2,
                                                            transferred_out: 14.2,
                                                            adjusted_cohort: 14.2,
                                                            graduates: 14.2,
                                                            continuing: 14.2,
                                                            adjusted_five_year_cohort_graduation_rate: 14.2,
                                                            cohort_dropout_rate: 14.2,
                                                            continuing_rate: 14.2,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'american indian or alaskan native').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 362,
                                                            transferred_in: 12.3,
                                                            transferred_out: 12.3,
                                                            adjusted_cohort: 12.3,
                                                            graduates: 12.3,
                                                            continuing: 12.3,
                                                            adjusted_five_year_cohort_graduation_rate: 12.3,
                                                            cohort_dropout_rate: 12.3,
                                                            continuing_rate: 12.3,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'asian').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 12,
                                                            transferred_in: 41.1,
                                                            transferred_out: 41.1,
                                                            adjusted_cohort: 41.1,
                                                            graduates: 41.1,
                                                            continuing: 41.1,
                                                            adjusted_five_year_cohort_graduation_rate: 41.1,
                                                            cohort_dropout_rate: 41.1,
                                                            continuing_rate: 41.1,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'asian pacific islander').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 144,
                                                            transferred_in: 13.4,
                                                            transferred_out: 13.4,
                                                            adjusted_cohort: 13.4,
                                                            graduates: 13.4,
                                                            continuing: 13.4,
                                                            adjusted_five_year_cohort_graduation_rate: 13.4,
                                                            cohort_dropout_rate: 13.4,
                                                            continuing_rate: 13.4,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'black or african american').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 123,
                                                            transferred_in: 45.3,
                                                            transferred_out: 45.3,
                                                            adjusted_cohort: 45.3,
                                                            graduates: 45.3,
                                                            continuing: 45.3,
                                                            adjusted_five_year_cohort_graduation_rate: 45.3,
                                                            cohort_dropout_rate: 45.3,
                                                            continuing_rate: 45.3,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'hispanic or latino').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 34,
                                                            transferred_in: 13.3,
                                                            transferred_out: 13.3,
                                                            adjusted_cohort: 13.3,
                                                            graduates: 13.3,
                                                            continuing: 13.3,
                                                            adjusted_five_year_cohort_graduation_rate: 13.3,
                                                            cohort_dropout_rate: 13.3,
                                                            continuing_rate: 13.3,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'pacific islander').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 132,
                                                            transferred_in: 12.8,
                                                            transferred_out: 12.8,
                                                            adjusted_cohort: 12.8,
                                                            graduates: 12.8,
                                                            continuing: 12.8,
                                                            adjusted_five_year_cohort_graduation_rate: 12.8,
                                                            cohort_dropout_rate: 12.8,
                                                            continuing_rate: 12.8,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'two or more races').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 145,
                                                            transferred_in: 54.5,
                                                            transferred_out: 54.5,
                                                            adjusted_cohort: 54.5,
                                                            graduates: 54.5,
                                                            continuing: 54.5,
                                                            adjusted_five_year_cohort_graduation_rate: 54.5,
                                                            cohort_dropout_rate: 54.5,
                                                            continuing_rate: 54.5,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'white').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 16,
                                                            transferred_in: 1.2,
                                                            transferred_out: 1.2,
                                                            adjusted_cohort: 1.2,
                                                            graduates: 1.2,
                                                            continuing: 1.2,
                                                            adjusted_five_year_cohort_graduation_rate: 1.2,
                                                            cohort_dropout_rate: 1.2,
                                                            continuing_rate: 1.2,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'foster care').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 543,
                                                            transferred_in: 84.5,
                                                            transferred_out: 84.5,
                                                            adjusted_cohort: 84.5,
                                                            graduates: 84.5,
                                                            continuing: 84.5,
                                                            adjusted_five_year_cohort_graduation_rate: 84.5,
                                                            cohort_dropout_rate: 84.5,
                                                            continuing_rate: 84.5,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'free or reduced price lunch').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 45,
                                                            transferred_in: 10.1,
                                                            transferred_out: 10.1,
                                                            adjusted_cohort: 10.1,
                                                            graduates: 10.1,
                                                            continuing: 10.1,
                                                            adjusted_five_year_cohort_graduation_rate: 10.1,
                                                            cohort_dropout_rate: 10.1,
                                                            continuing_rate: 10.1,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'transitional bilingual').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 172,
                                                            transferred_in: 1.7,
                                                            transferred_out: 1.7,
                                                            adjusted_cohort: 1.7,
                                                            graduates: 1.7,
                                                            continuing: 1.7,
                                                            adjusted_five_year_cohort_graduation_rate: 1.7,
                                                            cohort_dropout_rate: 1.7,
                                                            continuing_rate: 1.7,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'title i migrant').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 124,
                                                            transferred_in: 3.3,
                                                            transferred_out: 3.3,
                                                            adjusted_cohort: 3.3,
                                                            graduates: 3.3,
                                                            continuing: 3.3,
                                                            adjusted_five_year_cohort_graduation_rate: 3.3,
                                                            cohort_dropout_rate: 3.3,
                                                            continuing_rate: 3.3,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'section 504').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 235,
                                                            transferred_in: 10.2,
                                                            transferred_out: 10.2,
                                                            adjusted_cohort: 10.2,
                                                            graduates: 10.2,
                                                            continuing: 10.2,
                                                            adjusted_five_year_cohort_graduation_rate: 10.2,
                                                            cohort_dropout_rate: 10.2,
                                                            continuing_rate: 10.2,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'special education').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 235,
                                                            transferred_in: 10.2,
                                                            transferred_out: 10.2,
                                                            adjusted_cohort: 10.2,
                                                            graduates: 10.2,
                                                            continuing: 10.2,
                                                            adjusted_five_year_cohort_graduation_rate: 10.2,
                                                            cohort_dropout_rate: 10.2,
                                                            continuing_rate: 10.2,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'homeless').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
                                FiveYearGraduationRate.create(began_9_in_wa: 235,
                                                            transferred_in: 10.2,
                                                            transferred_out: 10.2,
                                                            adjusted_cohort: 10.2,
                                                            graduates: 10.2,
                                                            continuing: 10.2,
                                                            adjusted_five_year_cohort_graduation_rate: 10.2,
                                                            cohort_dropout_rate: 10.2,
                                                            continuing_rate: 10.2,
                                                            student_identifier_id: StudentIdentifier.find_by(name: 'all').id,
                                                            district_school_year_id: district_school_year.id,
                                                            county_school_year_id: county_school_year.id,
                                                            dropout_id: dropout.id)
    [school_year, county, educational_service_district, district, student_enrollment, district_school_year]
  end

  def create_graduation_rates_for_multiple_districts
    create_tags_and_identifiers
    school_year = SchoolYear.create(years: "2015-16")
    school_year2 = SchoolYear.create(years: "2014-15")
    county = County.create(name: "King", number: "17", slug: "king")
    educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
    student_enrollment = StudentEnrollment.create(total: 1378, students_per_classroom_teacher: 18)
    dropout = Dropout.create(year_1: 34,
                   year_2: 13,
                   year_3: 60,
                   year_4: 8)

    district4 = District.create(name: "Lake Washington School District", number: "17403", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "lake-washington-school-district")
    district_school_year4 = DistrictSchoolYear.create(district_id: district4.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 60,
                               cohort_dropout_rate: 40,
                               student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                               district_school_year_id: district_school_year4.id,
                               dropout_id: dropout.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 60,
                               cohort_dropout_rate: 40,
                               student_identifier_id: StudentIdentifier.find_by(name: 'all').id,
                               district_school_year_id: district_school_year4.id,
                               dropout_id: dropout.id)

    district = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
    district_school_year2 = DistrictSchoolYear.create(district_id: district.id, school_year_id: school_year2.id, student_enrollment_id: student_enrollment.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 15,
                                cohort_dropout_rate: 85,
                                student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                                district_school_year_id: district_school_year2.id,
                                dropout_id: dropout.id)

    district_school_year = DistrictSchoolYear.create(district_id: district.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 90,
                                cohort_dropout_rate: 10,
                                student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                                district_school_year_id: district_school_year.id,
                                dropout_id: dropout.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 90,
                                cohort_dropout_rate: 10,
                                student_identifier_id: StudentIdentifier.find_by(name: 'all').id,
                                district_school_year_id: district_school_year.id,
                                dropout_id: dropout.id)

    district2 = District.create(name: "Issaquah School District", number: "17411", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "issaquah-school-district")
    district_school_year2 = DistrictSchoolYear.create(district_id: district2.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 80,
                                cohort_dropout_rate: 20,
                                student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                                district_school_year_id: district_school_year2.id,
                                dropout_id: dropout.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 80,
                                cohort_dropout_rate: 20,
                                student_identifier_id: StudentIdentifier.find_by(name: 'all').id,
                                district_school_year_id: district_school_year2.id,
                                dropout_id: dropout.id)

    district3 = District.create(name: "Aberdeen School District", number: "17402", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "aberdeen-school-district")
    district_school_year3 = DistrictSchoolYear.create(district_id: district3.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 70,
                                cohort_dropout_rate: 30,
                                student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                                district_school_year_id: district_school_year3.id,
                                dropout_id: dropout.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 70,
                                cohort_dropout_rate: 30,
                                student_identifier_id: StudentIdentifier.find_by(name: 'all').id,
                                district_school_year_id: district_school_year3.id,
                                dropout_id: dropout.id)

    district5 = District.create(name: "Adna School District", number: "21226", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "adna-school-district")
    district_school_year5 = DistrictSchoolYear.create(district_id: district5.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 50,
                                cohort_dropout_rate: 50,
                                student_identifier_id: StudentIdentifier.find_by(name: 'female').id,
                                district_school_year_id: district_school_year5.id,
                                dropout_id: dropout.id)
    FiveYearGraduationRate.create(adjusted_five_year_cohort_graduation_rate: 50,
                                cohort_dropout_rate: 50,
                                student_identifier_id: StudentIdentifier.find_by(name: 'all').id,
                                district_school_year_id: district_school_year5.id,
                                dropout_id: dropout.id)

    [school_year, district, district2, district3, district4, district5]
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

require 'csv'

namespace :db do
  task import_demographic_data: :environment do
    CSV.foreach('./app/assets/data/DistrictDemographics.csv', headers: true) do |row|
      SchoolYear.find_or_create_by(years: row["SchoolYear"])
      EducationalServiceDistrict.find_or_create_by(name: row["ESD"]) do |esd|
        esd.slug = row["ESD"].parameterize
      end
      County.find_or_create_by(name: row["County"]) do |c|
        c.name = row["County"] || "N/A"
        c.number = row["CountyNumber"]
        c.slug = c.name.parameterize
      end
      District.create(name: row["District"],
                      number: row["CountyDistrictNumber"],
                      educational_service_district_id: EducationalServiceDistrict.find_by(name: row["ESD"]).id,
                      county_id: County.find_by(name: row["County"] || "N/A").id,
                      slug: row["District"].parameterize
                    )
      StudentEnrollment.create( school_year_id: SchoolYear.find_by(years: row["SchoolYear"]).id,
                                total: row["TotalEnrollment"],
                                students_per_classroom_teacher: row["StudentsPerClassroomTeacher"],
                                district_id: District.find_by(name: row["District"]).id
                              )
      RaceEthnicity.create( percent_american_indian_or_alaskan_native: row["PercentAmericanIndianorAlaskanNative"],
                            number_american_indian_or_alaskan_native: row["NumberAmericanIndianorAlaskanNative"],
                            percent_asian: row["PercentAsian"],
                            number_asian: row["NumberAsian"],
                            percent_pacific_islander: row["PercentPacificIslander"],
                            number_pacific_islander: row["NumberPacificIslander"],
                            percent_asian_pacific_islander: row["PercentAsianPacificIslander"],
                            number_asian_pacific_islander: row["NumberAsianPacificIslander"],
                            percent_black: row["PercentBlack"],
                            number_black: row["NumberBlack"],
                            percent_hispanic: row["PercentHispanic"],
                            number_hispanic: row["NumberHispanic"],
                            percent_white: row["PercentWhite"],
                            number_white: row["NumberWhite"],
                            percent_two_or_more: row["PercentTwoOrMoreRaces"],
                            number_two_or_more: row["NumberTwoOrMoreRaces"],
                            student_enrollment_id: StudentEnrollment.last.id
                          )
      Gender.create( percent_male: row["PercentMales"],
                     number_male: row["NumberMales"],
                     percent_female: row["PercentFemales"],
                     number_female: row["NumberFemales"],
                     student_enrollment_id: StudentEnrollment.last.id
                   )

      if row["NumberFosterCare"] == "N<10"
        number_foster_care = -10
      else
        number_foster_care = row["NumberFosterCare"]
      end

      OtherDemographic.create( percent_migrant: row["PercentMigrant"],
                                number_migrant: row["NumberMigrant"],
                                percent_transitional_bilingual: row["PercentTransitionalBilingual"],
                                number_transitional_bilingual: row["NumberTransitionalBilingual"],
                                percent_frl: row["PercentFreeorReducedPricedMeals"],
                                number_frl: row["NumberFreeorReducedPricedMeals"],
                                percent_foster_care: row["PercentFosterCare"],
                                number_foster_care: number_foster_care,
                                student_enrollment_id: StudentEnrollment.last.id
                              )
      ExceptionalStudentService.create( percent_special_education: row["PercentSpecialEducation"],
                                         number_special_education: row["NumberSpecialEducation"],
                                         percent_504: row["PercentSection504"],
                                         number_504: row["NumberSection504"],
                                         student_enrollment_id: StudentEnrollment.last.id
                                       )
    end
  end
end

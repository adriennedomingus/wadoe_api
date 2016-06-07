require 'csv'

files = ['./app/assets/data/demographics/DistrictDemographics08-09.csv',
         './app/assets/data/demographics/DistrictDemographics09-10.csv',
         './app/assets/data/demographics/DistrictDemographics10-11.csv',
         './app/assets/data/demographics/DistrictDemographics11-12.csv',
         './app/assets/data/demographics/DistrictDemographics12-13.csv',
         './app/assets/data/demographics/DistrictDemographics13-14.csv',
         './app/assets/data/demographics/DistrictDemographics14-15.csv']

namespace :db do
  task import_demographic_data: :environment do
    files.each do |file|
      CSV.foreach(file, headers: true) do |row|
        SchoolYear.find_or_create_by(years: row["SchoolYear"])
        EducationalServiceDistrict.find_or_create_by(name: row["ESD"]) do |esd|
          esd.slug = row["ESD"].parameterize
        end
        County.find_or_create_by(name: row["County"]) do |c|
          c.name = row["County"] || "N/A"
          c.number = row["CountyNumber"]
          c.slug = c.name.parameterize
        end
        District.find_or_create_by(name: row["District"]) do |d|
          d.name = row["District"]
          d.number = row["CountyDistrictNumber"]
          d.educational_service_district_id = EducationalServiceDistrict.find_by(name: row["ESD"]).id
          d.county_id = County.find_by(name: row["County"] || "N/A").id
          d.slug = row["District"].parameterize
        end
        se = StudentEnrollment.create( school_year_id: SchoolYear.find_by(years: row["SchoolYear"]).id,
                                  total: row["TotalEnrollment"],
                                  students_per_classroom_teacher: row["StudentsPerClassroomTeacher"],
                                  district_id: District.find_by(name: row["District"]).id
                                )

        if row["NumberFosterCare"] == "N<10"
          number_foster_care = -10
        else
          number_foster_care = row["NumberFosterCare"]
        end

        PopulationDemographic.create(number: row["NumberFemales"],
                                    percent: row["PercentFemales"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'female'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberMales"],
                                    percent: row["PercentMales"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'male'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberAmericanIndianorAlaskanNative"],
                                    percent: row["PercentAmericanIndianorAlaskanNative"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'american indian or alaskan native'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberAsian"],
                                    percent: row["PercentAsian"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'asian'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberAsianPacificIslander"],
                                    percent: row["PercentAsianPacificIslander"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'asian pacific islander'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberBlack"],
                                    percent: row["PercentBlack"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'black or african american'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberHispanic"],
                                    percent: row["PercentHispanic"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'hispanic or latino'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberPacificIslander"],
                                    percent: row["PercentPacificIslander"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'pacific islander'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberTwoOrMoreRaces"],
                                    percent: row["PercentTwoOrMoreRaces"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'two or more races'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberWhite"],
                                    percent: row["PercentWhite"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'white'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: number_foster_care,
                                    percent: row["PercentFosterCare"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'foster care'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberFreeorReducedPricedMeals"],
                                    percent: row["PercentFreeorReducedPricedMeals"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'free or reduced price lunch'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberTransitionalBilingual"],
                                    percent: row["PercentTransitionalBilingual"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'transitional bilingual'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberMigrant"],
                                    percent: row["PercentMigrant"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'title i migrant'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberSection504"],
                                    percent: row["PercentSection504"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'section 504'),
                                    student_enrollment_id: se.id)
        PopulationDemographic.create(number: row["NumberSpecialEducation"],
                                    percent: row["PercentSpecialEducation"],
                                    student_identifier_id: StudentIdentifier.find_by(name: 'special education'),
                                    student_enrollment_id: se.id)
      end
    end
  end
end

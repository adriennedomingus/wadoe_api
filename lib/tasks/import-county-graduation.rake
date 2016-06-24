require 'csv'

files = [

          './app/assets/data/graduation-county/2010-11-5YearGraduation-all.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-american_indian_or_alaskan_native.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-asian.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-asian_pacific_islander.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-black_or_african_american.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-female.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-free_or_reduced_price_lunch.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-hispanic_or_latino.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-male.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-pacific_islander.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-section_504.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-special_education.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-title_i_migrant.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-transitional_bilingual.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-two_or_more_races.csv',
          './app/assets/data/graduation-county/2010-11-5YearGraduation-white.csv',

          './app/assets/data/graduation-county/2011-12-5YearGraduation-all.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-american_indian_or_alaskan_native.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-asian.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-asian_pacific_islander.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-black_or_african_american.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-female.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-free_or_reduced_price_lunch.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-hispanic_or_latino.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-male.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-pacific_islander.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-section_504.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-special_education.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-title_i_migrant.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-transitional_bilingual.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-two_or_more_races.csv',
          './app/assets/data/graduation-county/2011-12-5YearGraduation-white.csv',


          './app/assets/data/graduation-county/2012-13-5YearGraduation-all.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-american_indian_or_alaskan_native.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-asian.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-asian_pacific_islander.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-black_or_african_american.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-female.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-foster_care.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-free_or_reduced_price_lunch.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-hispanic_or_latino.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-homeless.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-male.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-pacific_islander.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-section_504.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-special_education.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-title_i_migrant.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-transitional_bilingual.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-two_or_more_races.csv',
          './app/assets/data/graduation-county/2012-13-5YearGraduation-white.csv',

          './app/assets/data/graduation-county/2013-14-5YearGraduation-all.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-american_indian_or_alaskan_native.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-asian.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-black_or_african_american.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-female.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-foster_care.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-free_or_reduced_price_lunch.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-hispanic_or_latino.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-homeless.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-male.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-section_504.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-special_education.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-title_i_migrant.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-transitional_bilingual.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-two_or_more_races.csv',
          './app/assets/data/graduation-county/2013-14-5YearGraduation-white.csv',
        ]

namespace :db do
  task import_county_graduation_data: :environment do
    files.each do |file|
      CSV.foreach(file, headers: true) do |row|
        if row["Total Dropouts All 4 Years"]
          total_dropouts = row["Total Dropouts All 4 Years"]
        else
          total_dropouts = row["Dropouts Year 1"].to_i + row["Dropouts Year 2"].to_i + row["Dropouts Year 3"].to_i + row["Dropouts Year 4"].to_i + row["Dropouts Year 5"].to_i
        end

        identifier_name = file.chomp('.csv').split('-')[-1].split('_').join(" ")
        identifier = StudentIdentifier.find_by(name: identifier_name)
        dropout = Dropout.find_or_create_by(
                       year_1: row["Dropouts Year 1"].to_i,
                       year_2: row["Dropouts Year 2"].to_i,
                       year_3: row["Dropouts Year 3"].to_i,
                       year_4: row["Dropouts Year 4"].to_i,
                       year_5: row["Dropouts Year 5"].to_i,
                       total: total_dropouts
        )
        county = County.find_by(name: row["County"])
        school_year = SchoolYear.find_or_create_by(years: row["SchoolYear"])
          county_school_year = CountySchoolYear.find_or_create_by(county_id: county.id, school_year_id: school_year.id)
          FiveYearGraduationRate.create(county_school_year_id: county_school_year.id,
                                        student_identifier_id: identifier.id,
                                        dropout_id: dropout.id,
                                        began_9_in_wa: row["Began Grade 9 in Washington"].to_i,
                                        transferred_in: row["Transferred Into Washington"].to_i,
                                        transferred_out: row["Transferred Out"].to_i,
                                        adjusted_cohort: row["Adjusted Cohort"].to_i,
                                        graduates: row["Graduates"].to_i,
                                        continuing: row["Continuing"].to_i,
                                        adjusted_five_year_cohort_graduation_rate: row["Adjusted 5-Year Cohort Graduation Rate"].to_f,
                                        cohort_dropout_rate: row["Cohort dropout rate"].to_f,
                                        continuing_rate: row["Continuing Rate"].to_f
                                        )
      end
    end
  end
end

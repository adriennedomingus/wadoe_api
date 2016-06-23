class AddCountySchoolYearToFiveYearGraduationRates < ActiveRecord::Migration
  def change
    add_reference :five_year_graduation_rates, :county_school_year, index: true, foreign_key: true
  end
end

class SchoolYear < ActiveRecord::Base
  has_many :district_school_years
  has_many :five_year_graduation_rates, through: :district_school_years
  has_many :population_demographics, through: :district_school_years
end

class District < ActiveRecord::Base
  belongs_to :educational_service_district
  belongs_to :county

  has_many :district_school_years
  has_many :five_year_graduation_rates, through: :district_school_years
  has_many :student_enrollments,        through: :district_school_years
  has_many :population_demographics,    through: :district_school_years
end

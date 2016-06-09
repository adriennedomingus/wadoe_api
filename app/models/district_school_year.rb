class DistrictSchoolYear < ActiveRecord::Base
  belongs_to :school_year
  belongs_to :district
  belongs_to :student_enrollment

  has_many :five_year_graduation_rates
  has_many :population_demographics
  has_many :student_identifiers, through: :five_year_graduation_rates
  has_many :tags, through: :student_identifiers
  # has_many :student_identifiers, through: :population_demographics
  # has_many :tags, through: :student_identifiers

end

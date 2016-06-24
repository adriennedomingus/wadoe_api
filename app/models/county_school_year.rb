class CountySchoolYear < ActiveRecord::Base
  belongs_to :school_year
  belongs_to :county
  belongs_to :student_enrollment

  has_many :five_year_graduation_rates
  has_many :population_demographics
  has_many :student_identifiers, through: :five_year_graduation_rates
  has_many :tags, through: :student_identifiers
end

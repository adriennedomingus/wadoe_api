class SchoolYear < ActiveRecord::Base
  has_many :student_enrollments
  has_many :five_year_graduation_rates
  has_many :population_demographics, through: :student_enrollments
end

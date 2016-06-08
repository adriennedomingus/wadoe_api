class StudentEnrollment < ActiveRecord::Base
  belongs_to :school_year
  belongs_to :district
  has_many :population_demographics
end

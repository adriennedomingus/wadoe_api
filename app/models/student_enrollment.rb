class StudentEnrollment < ActiveRecord::Base
  belongs_to :school_year
  belongs_to :district
  has_one    :race_ethnicity
  has_one    :exceptional_student_service
  has_one    :other_demographic
  has_one    :gender
end

class District < ActiveRecord::Base
  belongs_to :educational_service_district
  belongs_to :county
  has_many   :student_enrollments
  has_many   :genders,                      through: :student_enrollments
  has_many   :race_ethnicities,             through: :student_enrollments
  has_many   :other_demographics,           through: :student_enrollments
  has_many   :exceptional_student_services, through: :student_enrollments
end

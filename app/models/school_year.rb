class SchoolYear < ActiveRecord::Base
  has_many :student_enrollments
end

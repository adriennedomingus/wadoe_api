class StudentEnrollment < ActiveRecord::Base
  belongs_to :school_year
  belongs_to :district
end

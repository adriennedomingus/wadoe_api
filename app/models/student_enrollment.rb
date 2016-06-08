class StudentEnrollment < ActiveRecord::Base
  has_one :district_school_year
  has_one :district, through: :district_school_year
  has_one :school_year, through: :district_school_year
end

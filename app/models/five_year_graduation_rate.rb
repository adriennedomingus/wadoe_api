class FiveYearGraduationRate < ActiveRecord::Base
  belongs_to :district
  belongs_to :school_year
  belongs_to :student_identifier
  has_one :dropout
end

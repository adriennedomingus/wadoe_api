class PopulationDemographic < ActiveRecord::Base
  belongs_to :student_identifiers
  belongs_to :student_enrollments
end

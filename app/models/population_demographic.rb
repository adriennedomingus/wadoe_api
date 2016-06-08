class PopulationDemographic < ActiveRecord::Base
  belongs_to :student_identifier
  belongs_to :student_enrollment
  belongs_to :district
end

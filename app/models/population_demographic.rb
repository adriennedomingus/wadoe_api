class PopulationDemographic < ActiveRecord::Base
  belongs_to :district_school_year
  belongs_to :student_identifier
end

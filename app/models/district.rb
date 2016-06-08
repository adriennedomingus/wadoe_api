class District < ActiveRecord::Base
  belongs_to :educational_service_district
  belongs_to :county
  has_many :student_enrollments
  has_many :population_demographics,      through: :student_enrollments
  has_many :five_year_graduation_rates
  has_many :dropouts,                     through: :five_year_graduation_rates
end

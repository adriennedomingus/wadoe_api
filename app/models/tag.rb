class Tag < ActiveRecord::Base
  has_many :student_identifiers
  has_many :five_year_graduation_rates, through: :student_identifiers
end

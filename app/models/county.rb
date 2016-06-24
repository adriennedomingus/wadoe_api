class County < ActiveRecord::Base
  has_many :districts

  has_many :county_school_years
  has_many :five_year_graduation_rates, through: :county_school_years
end

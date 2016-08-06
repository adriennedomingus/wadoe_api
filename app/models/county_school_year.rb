class CountySchoolYear < ActiveRecord::Base
  belongs_to :school_year
  belongs_to :county
  belongs_to :student_enrollment

  has_many :five_year_graduation_rates
  has_many :population_demographics
  has_many :student_identifiers, through: :five_year_graduation_rates
  has_many :tags, through: :student_identifiers

  def self.highest_cohort_graduation_rate(school_year, number, identifier)
    joins(:five_year_graduation_rates)
          .where(county_school_years: { school_year_id: school_year.id })
          .where(five_year_graduation_rates: { student_identifier_id: identifier.id})
          .order('five_year_graduation_rates.adjusted_five_year_cohort_graduation_rate DESC')
          .take(number)
  end
end

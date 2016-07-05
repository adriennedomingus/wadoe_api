class State
  include ActiveModel::Serialization

  attr_reader :years

  def initialize(years)
    @years = years
  end

  def total_students_in_school_year(years)
    school_year = SchoolYear.find_by(years: years)
    DistrictSchoolYear.joins(:student_enrollment)
                      .where(school_year_id: school_year.id)
                      .sum('student_enrollments.total')
  end

  def number_and_percent_students_of_demographic_in_school_year(years, student_identifier_name)
    school_year = SchoolYear.find_by(years: years)
    total_students_of_demographic_in_year = PopulationDemographic.joins(:student_identifier, :district_school_year)
                         .where(student_identifiers: { name: student_identifier_name }, district_school_years: {school_year_id: school_year.id})
                         .sum(:number)
    percent_students_of_demographic_in_year = ((total_students_of_demographic_in_year.to_f / total_students_in_school_year(school_year.years).to_f) * 100).round(2)
    [total_students_of_demographic_in_year, percent_students_of_demographic_in_year]
  end
end

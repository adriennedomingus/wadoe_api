class State
  def self.total_students_in_school_year(years)
    school_year = SchoolYear.find_by(years: years)
    DistrictSchoolYear.joins(:student_enrollment)
                      .where(school_year_id: school_year.id)
                      .sum('student_enrollments.total')
  end

  def self.number_and_percent_students_of_demographic_in_school_year(years, student_identifier_name)
    school_year = SchoolYear.find_by(years: years)
    PopulationDemographic.joins(:student_identifier, :district_school_year)
                         .where(student_identifiers: { name: student_identifier_name }, district_school_years: {school_year_id: school_year.id})
                         .sum(:number)

  end
end

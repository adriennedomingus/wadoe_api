class State
  def self.total_students_in_school_year(years)
    school_year = SchoolYear.find_by(years: years)
    DistrictSchoolYear.joins(:student_enrollment)
                      .where(school_year_id: school_year.id)
                      .sum('student_enrollments.total')
  end
end

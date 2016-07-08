require 'rails_helper'

RSpec.describe State, type: :model do
  it "totals the number of students in the state in a given school year" do
    school_year, _ = create_district_and_demographic_data
    district2 = District.create(name: "Issaquah School District", number: "17408", slug: "issaquah-school-district")
    student_enrollment2 = StudentEnrollment.create(total: 2475, students_per_classroom_teacher: 18)
    DistrictSchoolYear.create(district_id: district2.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment2.id)

    expect(State.new("2015-16").total_students_in_school_year("2015-16")).to eq(3853)
  end

  it "finds the number and percent of students of specific demographic in state in school year" do
    create_district_and_demographic_data
    total, percent = State.new("2015-16").number_and_percent_students_of_demographic_in_school_year("2015-16", "white")
    expect(total).to eq(145)
    expect(percent).to eq(10.52)
  end

  it "averages the vie_year_graduation_rates" do
    create_district_and_demographic_data
    white_average = State.new("2015-16").average_adjusted_five_year_cohort_graduation_rate_by_demographic_in_school_year("2015-16", "white")
    female_average = State.new("2015-16").average_adjusted_five_year_cohort_graduation_rate_by_demographic_in_school_year("2015-16", "female")
    expect(white_average).to eq(54.5)
    expect(female_average).to eq(49.2)
  end
end

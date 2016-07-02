require 'rails_helper'

RSpec.describe State do
  it "totals the number of students in the state in a given school year" do
    school_year = SchoolYear.create(years: "2015-16")
    school_year2 = SchoolYear.create(years: "2014-15")
    county = County.create(name: "King", number: "17", slug: "king")
    educational_service_district = EducationalServiceDistrict.create(name: "Puget Sound Educational Service District 121", slug: "puget-sound-educational-service-district-121")
    district = District.create(name: "Auburn School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
    student_enrollment = StudentEnrollment.create(total: 1378, students_per_classroom_teacher: 18)
    district_school_year = DistrictSchoolYear.create(district_id: district.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment.id)
    district2 = District.create(name: "Seattle School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
    student_enrollment2 = StudentEnrollment.create(total: 2475, students_per_classroom_teacher: 18)
    district_school_year = DistrictSchoolYear.create(district_id: district2.id, school_year_id: school_year.id, student_enrollment_id: student_enrollment2.id)
    district3 = District.create(name: "Issaquah School District", number: "17408", educational_service_district_id: educational_service_district.id, county_id: county.id, slug: "auburn-school-district")
    student_enrollment3 = StudentEnrollment.create(total: 2475, students_per_classroom_teacher: 18)
    district_school_year = DistrictSchoolYear.create(district_id: district3.id, school_year_id: school_year2.id, student_enrollment_id: student_enrollment3.id)

    expect(State.total_students_in_school_year("2015-16")).to eq(3853)
  end
end

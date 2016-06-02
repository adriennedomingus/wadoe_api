class DistrictDemographicsInYearSerializer< ActiveModel::Serializer
  has_one :district

  attributes :total,
             :students_per_classroom_teacher

  has_one :gender
  has_one :exceptional_student_service
  has_one :race_ethnicity
  has_one :other_demographic
end

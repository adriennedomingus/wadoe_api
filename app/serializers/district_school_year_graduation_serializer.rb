class DistrictSchoolYearGraduationSerializer < ActiveModel::Serializer
  include ObjectSchoolYearSerializer

  has_one :district
  has_one :school_year
  attributes :graduation
end

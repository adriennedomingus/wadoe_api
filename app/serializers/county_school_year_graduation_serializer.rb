class CountySchoolYearGraduationSerializer < ActiveModel::Serializer
  include ObjectSchoolYearSerializer

  has_one :county
  has_one :school_year
  attributes :graduation
end

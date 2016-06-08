class DistrictSchoolYearSerializer < ActiveModel::Serializer
  attributes :tags
  has_one :district
  has_one :school_year
  has_one :student_enrollment

  def tags
    all_tags = []
    object.tags.each do |tag|
      custom_tag = tag.attributes
      #Working in here right now to get tag -> student identifiers -> relevant population demographics
      all_tags.push(custom_tag)
    end
    all_tags
  end
end

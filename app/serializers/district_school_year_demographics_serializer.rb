class DistrictSchoolYearDemographicsSerializer < ActiveModel::Serializer
  has_one :district
  has_one :school_year
  has_one :student_enrollment
  attributes :demographics

  def demographics
    all_tags = []
    object.tags.each do |tag|
      unless tag.name == "all"
        custom_tag = {tag.name => {}}
        tag.student_identifiers.each do |si|
          pd = si.population_demographics.where(district_school_year_id: object.id)[0]
          if pd
            custom_tag[tag.name][si.name] = { number: pd.number, percent: pd.percent }
          end
        end
        all_tags.push(custom_tag)
      end
    end
    all_tags.uniq
  end
end

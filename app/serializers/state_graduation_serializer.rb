class StateGraduationSerializer < ActiveModel::Serializer
  attributes :graduation

  def graduation
    all_tags = []
    Tag.all.each do |tag|
      unless tag.name == "all"
        custom_tag = {tag.name => {}}
        tag.student_identifiers.each do |si|
          percent = object.average_adjusted_five_year_cohort_graduation_rate_by_demographic_in_school_year(object.years, si.name)
          custom_tag[tag.name][si.name] = { percent: percent }
        end
        all_tags.push(custom_tag)
      end
    end
    all_tags
  end
end

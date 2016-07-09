class StateDemographicsSerializer < ActiveModel::Serializer
  attributes :demographics

  def demographics
    all_tags = []
    Tag.all.each do |tag|
      unless tag.name == "all"
        custom_tag = {tag.name => {}}
        tag.student_identifiers.each do |si|
          number, percent = object.number_and_percent_students_of_demographic_in_school_year(object.years, si.name)
          custom_tag[tag.name][si.name] = { number: number, percent: percent }
        end
        all_tags.push(custom_tag)
      end
    end
    all_tags
  end
end

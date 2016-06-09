class DistrictSchoolYearGraduationSerializer < ActiveModel::Serializer
  has_one :district
  has_one :school_year
  attributes :graduation

  def graduation
    all_tags = []
    object.tags.each do |tag|
      custom_tag = {tag.name => {}}
      tag.student_identifiers.each do |si|
        five_year_graduation_rate = si.five_year_graduation_rates.where(district_school_year_id: object.id)[0]
        if five_year_graduation_rate
          custom_tag[tag.name][si.name] = { began_9_in_wa: five_year_graduation_rate.began_9_in_wa,
                                            transferred_into_wa: five_year_graduation_rate.transferred_in,
                                            transferred_out: five_year_graduation_rate.transferred_out,
                                            adjusted_cohort: five_year_graduation_rate.adjusted_cohort,
                                            graduates: five_year_graduation_rate.graduates,
                                            continuing: five_year_graduation_rate.continuing,
                                            adjusted_five_year_cohort_graduation_rate: five_year_graduation_rate.adjusted_five_year_cohort_graduation_rate,
                                            cohort_dropout_rate: five_year_graduation_rate.cohort_dropout_rate,
                                            continuing_rate: five_year_graduation_rate.continuing_rate,
                                            dropouts: {
                                              year1: five_year_graduation_rate.dropout.year_1,
                                              year2: five_year_graduation_rate.dropout.year_2,
                                              year3: five_year_graduation_rate.dropout.year_3,
                                              year4: five_year_graduation_rate.dropout.year_4,
                                              year5: five_year_graduation_rate.dropout.year_5
                                              }}
        end
      end
      all_tags.push(custom_tag)
    end
    all_tags.uniq
  end
end

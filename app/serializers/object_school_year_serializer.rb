module ObjectSchoolYearSerializer
  def graduation
    tag_from_params = Tag.find_by(name: scope)
    identifier_from_params = StudentIdentifier.find_by(name: scope)
    if tag_from_params
      specific_tag_response(tag_from_params)
    elsif identifier_from_params
      specific_identifier_response(identifier_from_params)
    else
      all_tags_response
    end
  end

  def response_hash(five_year_graduation_rate)
    { began_9_in_wa: five_year_graduation_rate.began_9_in_wa,
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

  def specific_tag_response(tag_from_params)
    custom_tag = {tag_from_params.name => {}}
    tag_from_params.student_identifiers.each do |si|
      add_statistics_to_tag(custom_tag, si, tag_from_params)
    end
    [custom_tag]
  end

  def specific_identifier_response(identifier)
    if object.class == DistrictSchoolYear
      { identifier.name => response_hash(identifier.five_year_graduation_rates.where(district_school_year_id: object.id)[0])}
    elsif object.class == CountySchoolYear
      { identifier.name => response_hash(identifier.five_year_graduation_rates.where(county_school_year_id: object.id)[0])}
    end
  end

  def all_tags_response
    all_tags = []
    Tag.all.each do |tag|
      custom_tag = {tag.name => {}}
      tag.student_identifiers.each do |si|
        add_statistics_to_tag(custom_tag, si, tag)
      end
      all_tags.push(custom_tag)
    end
    all_tags.uniq
  end

  def add_statistics_to_tag(custom_tag, si, tag)
    if object.class == DistrictSchoolYear
      five_year_graduation_rate = si.five_year_graduation_rates.where(district_school_year_id: object.id)[0]
    elsif object.class == CountySchoolYear
      five_year_graduation_rate = si.five_year_graduation_rates.where(county_school_year_id: object.id)[0]
    end
    if five_year_graduation_rate
      custom_tag[tag.name][si.name] = response_hash(five_year_graduation_rate)
    end
  end
end

class OtherDemographicSerializer < ActiveModel::Serializer
  attributes :percent_migrant,
             :number_migrant,
             :percent_transitional_bilingual,
             :number_transitional_bilingual,
             :percent_frl,
             :number_frl,
             :percent_foster_care,
             :number_foster_care
end

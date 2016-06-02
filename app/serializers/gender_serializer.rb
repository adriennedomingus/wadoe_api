class GenderSerializer < ActiveModel::Serializer
  attributes :percent_male, :number_male, :percent_female, :number_female
end

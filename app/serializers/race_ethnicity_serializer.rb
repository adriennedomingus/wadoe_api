class RaceEthnicitySerializer < ActiveModel::Serializer
  attributes :percent_american_indian_or_alaskan_native,
             :number_american_indian_or_alaskan_native,
             :percent_asian,
             :number_asian,
             :percent_pacific_islander,
             :number_pacific_islander,
             :percent_asian_pacific_islander,
             :number_asian_pacific_islander,
             :percent_black,
             :number_black,
             :percent_hispanic,
             :number_hispanic,
             :percent_white,
             :number_white,
             :percent_two_or_more,
             :number_two_or_more
end

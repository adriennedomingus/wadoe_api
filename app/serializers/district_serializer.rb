class DistrictSerializer < ActiveModel::Serializer
  attributes :name, :number, :slug
  has_one :educational_service_district
  has_one :county, serializer: CountySerializer
end

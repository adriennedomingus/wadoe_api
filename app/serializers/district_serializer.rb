class DistrictSerializer < ActiveModel::Serializer
  attributes :name, :slug, :number
  has_one :educational_service_district
  has_one :county
end

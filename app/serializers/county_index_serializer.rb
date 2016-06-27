class CountyIndexSerializer < ActiveModel::Serializer
  attributes :name, :slug, :number
  has_many :districts
end

class County < ActiveRecord::Base
  has_many :districts
end

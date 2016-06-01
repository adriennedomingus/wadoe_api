class District < ActiveRecord::Base
  belongs_to :educational_service_district
  belongs_to :county
end

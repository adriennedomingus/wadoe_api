class District < ActiveRecord::Base
  belongs_to :educational_service_district
  belongs_to :county

  def self.all_districts
    response = { districts: [
      ]
    }
    all.each do |district|
      response[:districts] << {
        name: district.name,
        slug: district.slug,
        number: district.number,
        educational_service_district: district.educational_service_district.name,
        educational_service_district_slug: district.educational_service_district.slug,
        county: district.county.name,
        county_slug: district.county.slug,
      }
    end
    response.to_json
  end
end

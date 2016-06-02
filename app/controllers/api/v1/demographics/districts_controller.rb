class Api::V1::Demographics::DistrictsController < Api::ApiController
  respond_to :json

  def show
    district = District.find_by(slug: params["slug"])
    year = SchoolYear.find_by(years: params["year"])
    se = StudentEnrollment.where(district_id: district.id, school_year_id: year.id)
    respond_with se[0], serializer: DistrictDemographicsInYearSerializer
  end
end

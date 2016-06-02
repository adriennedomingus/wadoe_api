class Api::V1::Demographics::DistrictsController < Api::ApiController
  respond_to :json

  def show
    district = District.find_by(slug: params["slug"])
    year = SchoolYear.find_by(years: params["year"])
    if year && district
      se = StudentEnrollment.where(district_id: district.id, school_year_id: year.id)
      respond_with se[0], serializer: DistrictDemographicsInYearSerializer
    else
      message = "We do not have data for that combination of school district and school year. Please try another query."
      status = 400
      response = { message: message, status: status }.to_json
      respond_with response
    end
  end
end

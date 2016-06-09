class Api::V1::Demographics::DistrictsController < Api::ApiController
  respond_to :json

  def show
    message, options = district_in_year_repsonse(params, DistrictSchoolYearDemographicsSerializer)
    respond_with message, options
  end
end

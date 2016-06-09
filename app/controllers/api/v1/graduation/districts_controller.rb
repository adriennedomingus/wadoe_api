class Api::V1::Graduation::DistrictsController < Api::ApiController
  respond_to :json

  def show
    message, options = district_in_year_repsonse(params, DistrictSchoolYearGraduationSerializer)
    respond_with message, options
  end
end

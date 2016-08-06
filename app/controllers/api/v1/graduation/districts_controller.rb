class Api::V1::Graduation::DistrictsController < Api::V1::GraduationController
  respond_to :json

  def show
    message, options = district_in_year_repsonse(params, DistrictSchoolYearGraduationSerializer)
    respond_with message, options
  end

  def highest
    response, options = highest_rate(DistrictSchoolYear, DistrictSchoolYearGraduationSerializer)
    respond_with response, options
  end

end

class Api::V1::Graduation::CountiesController < Api::V1::GraduationController
  respond_to :json

  def show
    message, options = county_in_year_repsonse(params, CountySchoolYearGraduationSerializer)
    respond_with message, options
  end

  def highest
    response, options = highest_rate(CountySchoolYear, CountySchoolYearGraduationSerializer)
    respond_with response, options
  end
end

class Api::V1::Graduation::CountiesController < Api::ApiController
  respond_to :json

  def show
    message, options = county_in_year_repsonse(params, CountySchoolYearGraduationSerializer)
    respond_with message, options
  end
end

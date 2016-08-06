class Api::V1::Graduation::CountiesController < Api::ApiController
  respond_to :json

  def show
    message, options = county_in_year_repsonse(params, CountySchoolYearGraduationSerializer)
    respond_with message, options
  end

  def highest
    identifier_name = set_identifier(params)
    identifier = StudentIdentifier.find_by(name: identifier_name)
    number = set_top(params)
    school_year = SchoolYear.find_by(years: params[:year])
    if !school_year
      message = "We do not have data for that school year. Please try another query."
      response = { message: message, status: 404 }.to_json
      respond_with response, {status: 404}
    elsif authenticated_api_key?(params[:api_key])
      district_school_years = CountySchoolYear.highest_cohort_graduation_rate(school_year, number, identifier)
      respond_with district_school_years, each_serializer: CountySchoolYearGraduationSerializer, scope: identifier_name
    else
      respond_with unauthorized_response, status: 401, head: :unauthorized
    end
  end

  private

    def set_identifier(params)
      if params[:identifier]
        params[:identifier]
      else
        "all"
      end
    end

    def set_top(params)
      if params[:top]
        params[:top]
      else
        10
      end
    end
end

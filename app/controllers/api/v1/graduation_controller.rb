class Api::V1::GraduationController < Api::ApiController
  def highest_rate(object, serializer)
    identifier_name = set_identifier(params)
    identifier = StudentIdentifier.find_by(name: identifier_name)
    number = set_top(params)
    school_year = SchoolYear.find_by(years: params[:year])
    if !school_year
      message = "We do not have data for that school year. Please try another query."
      response = { message: message, status: 404 }.to_json
      [response, {status: 404}]
    elsif authenticated_api_key?(params[:api_key])
      district_school_years = object.highest_cohort_graduation_rate(school_year, number, identifier)
      [district_school_years, each_serializer: serializer, scope: identifier_name]
    else
      [unauthorized_response, status: 401, head: :unauthorized]
    end
  end

  private
    def set_identifier(params)
      params[:identifier] ? params[:identifier] : "all"
    end

    def set_top(params)
      params[:top] ? params[:top] : 10
    end
end

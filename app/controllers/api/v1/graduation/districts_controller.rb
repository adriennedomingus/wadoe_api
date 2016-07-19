class Api::V1::Graduation::DistrictsController < Api::ApiController
  respond_to :json

  def show
    message, options = district_in_year_repsonse(params, DistrictSchoolYearGraduationSerializer)
    respond_with message, options
  end

  def highest
    identifier = set_identifier(params)
    number = set_top(params)
    school_year = SchoolYear.find_by(years: params[:year])
    if !school_year
      message = "We do not have data for that school year. Please try another query."
      response = { message: message, status: 404 }.to_json
      respond_with response, {status: 404}
    elsif User.find_by(api_key: params[:api_key])
      district_school_years = DistrictSchoolYear.joins(:five_year_graduation_rates)
                          .where(district_school_years: { school_year_id: school_year.id })
                          .order('five_year_graduation_rates.adjusted_five_year_cohort_graduation_rate DESC')
                          .take(number)
      respond_with district_school_years, each_serializer: DistrictSchoolYearGraduationSerializer, scope: identifier
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

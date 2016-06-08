class Api::V1::Demographics::DistrictsController < Api::ApiController
  respond_to :json

  def show
    district = District.find_by(slug: params["slug"])
    year = SchoolYear.find_by(years: params["year"])
    key = params[:api_key]
    if invalid_request(district, year)
      message = invalid_request(district, year)
      response = { message: message, status: 404 }.to_json
      respond_with response, status: 404
    elsif authenticated_api_key?(key)
      district_school_year = DistrictSchoolYear.find_by(district_id: district.id, school_year_id: year.id)
      respond_with district_school_year
    else
      respond_with unauthorized_response, status: 401, head: :unauthorized
    end
  end

  private
    def invalid_request(district, year)
      if invalid_district_and_year(district, year)
        "We do not have data for that school district or school year. Please try another query."
      elsif invalid_school_district(district, year)
        "We do not have that school district in our system. Please try another query"
      elsif invalid_school_year(district, year)
        "We do not have data for that school year. Please try another query."
      end
    end

    def invalid_district_and_year(district, year)
      !year && !district
    end

    def invalid_school_district(district, year)
      year && !district
    end

    def invalid_school_year(district, year)
      !year && district
    end
end

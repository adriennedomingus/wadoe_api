require 'json'

class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def district_in_year_repsonse(params, serializer)
    district = District.find_by(slug: params["slug"])
    year = SchoolYear.find_by(years: params["year"])
    key = params[:api_key]
    if invalid_request(district, year)
      response_to_invalid_request(district, year)
    elsif authenticated_api_key?(key)
      response_to_authenticated_request(district, year, serializer, params)
    else
      [unauthorized_response, { status: 401, head: :unauthorized }]
    end
  end

  def county_in_year_repsonse(params, serializer)
    county = County.find_by(slug: params["slug"])
    year = SchoolYear.find_by(years: params["year"])
    key = params[:api_key]
    if invalid_request(county, year)
      response_to_invalid_request(county, year)
    elsif authenticated_api_key?(key)
      response_to_authenticated_county_request(county, year, serializer, params)
    else
      [unauthorized_response, { status: 401, head: :unauthorized }]
    end
  end

  def authenticated_api_key?(key)
    User.find_by(api_key: key)
  end

  def unauthorized_response
    message = "Please include a valid API key with your request"
    { message: message, status: 401 }.to_json
  end

  private

    def response_to_invalid_request(district, year)
      message = invalid_request(district, year)
      response = { message: message, status: 404 }.to_json
      [response, {status: 404} ]
    end

    def response_to_authenticated_request(district, year, serializer, params)
      district_school_year = DistrictSchoolYear.find_by(district_id: district.id, school_year_id: year.id)
      if params[:graduation_tag]
        [district_school_year, serializer: serializer, scope: params[:graduation_tag]]
      else
        [district_school_year, { serializer: serializer }]
      end
    end

    def response_to_authenticated_county_request(county, year, serializer, params)
      county_school_year = CountySchoolYear.find_by(county_id: county.id, school_year_id: year.id)
      if params[:graduation_tag]
        [county_school_year, serializer: serializer, scope: params[:graduation_tag]]
      else
        [county_school_year, { serializer: serializer }]
      end
    end

    def invalid_request(district, year)
      if invalid_district_and_year(district, year)
        "We do not have data for that school district/county or school year. Please try another query."
      elsif invalid_school_district(district, year)
        "We do not have that school district/county in our system. Please try another query"
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

    def invalid_county_and_year(county, year)
      !year && !county
    end

    def invalid_school_county(county, year)
      year && !county
    end

    def invalid_school_year(county, year)
      !year && county
    end
end

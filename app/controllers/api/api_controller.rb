require 'json'

class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def district_in_year_repsonse(params, serializer)
    district = District.find_by(slug: params["slug"])
    response_path(district, serializer, params)
  end

  def county_in_year_repsonse(params, serializer)
    county = County.find_by(slug: params["slug"])
    response_path(county, serializer, params)
  end

  def authenticated_api_key?(key)
    User.find_by(api_key: key)
  end

  def unauthorized_response
    message = "Please include a valid API key with your request"
    { message: message, status: 401 }.to_json
  end

  def index_response(params, type, serializer)
    key = params[:api_key]
    if authenticated_api_key?(key)
      counties = type.all
      counties_per_page = params[:per_page] || 25
      paginate json: counties, per_page: counties_per_page, each_serializer: serializer
    else
      respond_with unauthorized_response, status: 401, head: :unauthorized
    end
  end

  private

    def response_path(object, serializer, params)
      year = SchoolYear.find_by(years: params["year"])
      key = params[:api_key]
      if invalid_request(object, year)
        response_to_invalid_request(object, year)
      elsif authenticated_api_key?(key)
        response_to_authenticated_request(object, year, serializer, params)
      else
        [unauthorized_response, { status: 401, head: :unauthorized }]
      end
    end

    def response_to_invalid_request(district, year)
      message = invalid_request(district, year)
      response = { message: message, status: 404 }.to_json
      [response, {status: 404} ]
    end

    def response_to_authenticated_request(object, year, serializer, params)
      if object.class == District
        return_object = DistrictSchoolYear.find_by(district_id: object.id, school_year_id: year.id)
      elsif object.class == County
        return_object = CountySchoolYear.find_by(county_id: object.id, school_year_id: year.id)
      else
        return_object = State.new(year.years)
      end
      response_object(return_object, serializer, params)
    end

    def response_object(object_school_year, serializer, params)
      if params[:graduation_tag]
        [object_school_year, serializer: serializer, scope: params[:graduation_tag]]
      elsif serializer
        [object_school_year, { serializer: serializer }]
      end
    end

    def invalid_request(object, year)
      if invalid_object_and_year(object, year)
        "We do not have data for that school district/county or school year. Please try another query."
      elsif invalid_school_object(object, year)
        "We do not have that school district/county in our system. Please try another query"
      elsif invalid_school_year(object, year)
        "We do not have data for that school year. Please try another query."
      end
    end

    def invalid_object_and_year(object, year)
      !year && !object
    end

    def invalid_school_object(object, year)
      year && !object
    end

    def invalid_school_year(object, year)
      !year && object
    end
end

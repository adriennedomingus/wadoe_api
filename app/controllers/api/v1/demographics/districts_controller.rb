class Api::V1::Demographics::DistrictsController < Api::ApiController
  respond_to :json

  def show
    district = District.find_by(slug: params["slug"])
    year = SchoolYear.find_by(years: params["year"])
    if invalid_request(district, year)
      message = invalid_request(district, year)
      response = { message: message, status: 404 }.to_json
      respond_with response, status: 404
    else
      student_enrollment = StudentEnrollment.where(district_id: district.id, school_year_id: year.id)
      respond_with student_enrollment[0], serializer: DistrictDemographicsInYearSerializer
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

class Api::V1::Graduation::DistrictsController < Api::ApiController
  respond_to :json

  def show
    message, options = district_in_year_repsonse(params, DistrictSchoolYearGraduationSerializer)
    respond_with message, options
  end

  def highest
    school_year = SchoolYear.find_by(years: params[:year])
    number = params[:top]
    district_school_years = DistrictSchoolYear.joins(:five_year_graduation_rates)
                        .where(district_school_years: { school_year_id: school_year.id })
                        .order('five_year_graduation_rates.adjusted_five_year_cohort_graduation_rate DESC')
                        .take(number)
    respond_with district_school_years, each_serializer: DistrictSchoolYearGraduationSerializer, scope: params[:identifier]
  end
end

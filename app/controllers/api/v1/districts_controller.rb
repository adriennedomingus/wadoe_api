class Api::V1::DistrictsController < Api::ApiController
  respond_to :json

  def index
    key = params[:api_key]
    if authenticated_api_key?(key)
      districts = District.all
      districts_per_page = params[:per_page] || 25
      paginate json: districts, per_page: districts_per_page
    else
      respond_with unauthorized_response, status: 401, head: :unauthorized
    end
  end
end

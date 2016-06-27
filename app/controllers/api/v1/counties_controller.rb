class Api::V1::CountiesController < Api::ApiController
  respond_to :json

  def index
    key = params[:api_key]
    if authenticated_api_key?(key)
      counties = County.all
      counties_per_page = params[:per_page] || 25
      paginate json: counties, per_page: counties_per_page, each_serializer: CountyIndexSerializer
    else
      respond_with unauthorized_response, status: 401, head: :unauthorized
    end
  end
end

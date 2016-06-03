class Api::V1::DistrictsController < Api::ApiController
  respond_to :json

  def index
    key = params[:api_key]
    if authenticated_api_key?(key)
      respond_with District.all
    else
      respond_with unauthorized_response, status: 401, head: :unauthorized
    end
  end
end

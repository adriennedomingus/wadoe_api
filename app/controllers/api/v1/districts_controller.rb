class Api::V1::DistrictsController < Api::ApiController
  respond_to :json

  def index
    index_response(params, District, DistrictSerializer)
  end
end

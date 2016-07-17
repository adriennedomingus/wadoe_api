class Api::V1::CountiesController < Api::ApiController
  respond_to :json

  def index
    index_response(params, County, CountyIndexSerializer)
  end
end

class Api::V1::DistrictsController < Api::ApiController
  respond_to :json

  def index
    respond_with District.all
  end
end

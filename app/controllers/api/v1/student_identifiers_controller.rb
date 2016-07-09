class Api::V1::StudentIdentifiersController < Api::ApiController
  respond_to :json

  def index
    respond_with StudentIdentifier.pluck(:name)
  end
end

class Api::V1::Demographics::StateController < Api::ApiController
  respond_to :json

  def show
    message, options = response_path(State.new(params[:year]), StateSerializer, params)
    respond_with message, options
  end
end

class Api::V1::Demographics::StateController < Api::ApiController
  respond_to :json

  def show
    respond_with State.new(params[:year])
  end
end

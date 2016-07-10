class Api::V1::Graduation::StateController < Api::ApiController
  respond_to :json

  def show
    message, options = response_path(State.new(params[:year]), StateGraduationSerializer, params)
    respond_with message, options
  end
end

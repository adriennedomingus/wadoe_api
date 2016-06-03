require 'json'

class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def authenticated_api_key?(key)
    User.find_by(api_key: key)
  end

  def unauthorized_response
    message = "Please include a valid API key with your request"
    { message: message, status: 401 }.to_json
  end
end

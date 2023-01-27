class MembersController < ApplicationController
  before_action :auth_user

  def index
    render json: current_user
  end

  private

  def auth_user
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    User.find(jwt_payload['sub'])
  end

end

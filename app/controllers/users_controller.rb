class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.create!(user_params)
    user_token = AuthenticateUser.new(user.email, user.password).call
    render json: { user_token: user_token }, status: :created
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end

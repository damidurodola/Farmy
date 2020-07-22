class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    token = AuthenticateUser.new(login_params[:email], login_params[:password]).call
    render json: { token: token }, status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end

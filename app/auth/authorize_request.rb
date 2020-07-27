class AuthorizeRequest

  def initialize(headers = {})
    @headers = headers
  end

  def call
    {
      user: user
    }
  end

  private
  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token

  rescue ActiveRecord::RecordNotFound => e
    raise(
      "#{e.message}"
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)

  rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
    head :unauthorized
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
  end
end

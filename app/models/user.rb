class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }
end

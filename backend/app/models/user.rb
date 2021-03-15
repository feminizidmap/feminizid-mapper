# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :changes_made, class_name: 'Change', dependent: :nullify

  enum role: { user: 0, reviewer: 1, admin: 2 }

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
end

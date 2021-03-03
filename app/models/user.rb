# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :changes_made, class_name: 'Change', dependent: :nullify
end

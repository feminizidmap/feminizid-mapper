# frozen_string_literal: true

class SystemSetting < ApplicationRecord
  include ActiveModel::Serializers::JSON
  serialize :value

  validates :key, presence: true
  validates :value, presence: true
end

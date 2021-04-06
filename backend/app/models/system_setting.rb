# frozen_string_literal: true

class SystemSetting < ApplicationRecord
  self.implicit_order_column = 'created_at'

  include ActiveModel::Serializers::JSON
  serialize :value

  validates :key, presence: true
  validates :value, presence: true
end

# frozen_string_literal: true

class Fcase < ApplicationRecord
  self.implicit_order_column = 'created_at'

  include ActiveModel::Serializers::JSON

  serialize :sources

  validates :ident, presence: true

  has_many :victims, dependent: :destroy
end

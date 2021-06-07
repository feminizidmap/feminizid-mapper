# frozen_string_literal: true

class Fcase < ApplicationRecord
  self.implicit_order_column = 'created_at'

  include ActiveModel::Serializers::JSON

  serialize :sources, JSON

  validates :ident, presence: true

  has_many :victims, dependent: :destroy
  has_many :perpetrators, dependent: :destroy
  has_one :crime, dependent: :destroy
end

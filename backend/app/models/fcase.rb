# frozen_string_literal: true

class Fcase < ApplicationRecord
  self.implicit_order_column = 'created_at'

  has_many :victims, dependent: :destroy

  serialize :sources

  validates :ident, presence: true
end

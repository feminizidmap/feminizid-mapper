# frozen_string_literal: true

class Attribute < ApplicationRecord
  belongs_to :entity
  has_one :category
  has_one :category_item
end

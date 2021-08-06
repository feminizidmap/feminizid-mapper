# frozen_string_literal: true

class Attribute < ApplicationRecord
  belongs_to :entity
  belongs_to :category
  belongs_to :category_item
end

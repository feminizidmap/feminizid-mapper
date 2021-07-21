# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_items
end

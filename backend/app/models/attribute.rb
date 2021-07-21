# frozen_string_literal: true

class Attribute < ApplicationRecord
  belongs_to :entity
  has_one :codelist
  has_one :codelist_item
end

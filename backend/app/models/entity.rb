# frozen_string_literal: true

class Entity < ApplicationRecord
  belongs_to :record
  has_many :fields
  has_many :attributes
end

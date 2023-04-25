# frozen_string_literal: true

class Entity < ApplicationRecord
  belongs_to :record
  has_many :fields, dependent: :destroy
  has_many :properties, class_name: 'Attribute', dependent: :destroy

  accepts_nested_attributes_for :fields, :properties, allow_destroy: true
end

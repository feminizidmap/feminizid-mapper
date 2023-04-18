# frozen_string_literal: true

class Record < ApplicationRecord
  has_many :sources, dependent: :destroy
  has_many :entities, dependent: :destroy
  has_many :history, class_name: 'Change', dependent: :destroy

  accepts_nested_attributes_for :sources, allow_destroy: true
  accepts_nested_attributes_for :entities
end

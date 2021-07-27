# frozen_string_literal: true

class Record < ApplicationRecord
  has_many :sources, dependent: :destroy
  has_many :entities, dependent: :destroy
  has_many :history, class_name: 'Change', dependent: :destroy
end

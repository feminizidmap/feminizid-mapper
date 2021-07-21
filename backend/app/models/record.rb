# frozen_string_literal: true

class Record < ApplicationRecord
  has_many :sources, dependent: :destroy
  has_many :entities, dependent: :destroy
  has_many :changes, dependent: :destroy
end

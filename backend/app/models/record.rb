# frozen_string_literal: true

class Record < ApplicationRecord
  has_many :sources
  has_many :entities
  has_many :changes
end

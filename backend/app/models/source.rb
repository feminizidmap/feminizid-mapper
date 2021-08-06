# frozen_string_literal: true

class Source < ApplicationRecord
  belongs_to :record

  validates :url, url: true
end

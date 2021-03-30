# frozen_string_literal: true

class Fcase < ApplicationRecord
  include ActiveModel::Serializers::JSON

  serialize :sources

  validates :ident, presence: true
end

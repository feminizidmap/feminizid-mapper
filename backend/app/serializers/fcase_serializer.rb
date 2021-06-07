# frozen_string_literal: true

class FcaseSerializer
  include JSONAPI::Serializer
  attributes :ident, :created_at, :updated_at, :sources

  has_many :victims
  has_many :perpetrators
end

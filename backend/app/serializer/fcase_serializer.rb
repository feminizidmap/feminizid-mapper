# frozen_string_literal: true

class FcaseSerializer < ActiveModel::Serializer
  attributes  :id,
              :ident,
              :created_at,
              :sources
  has_many :victims
end

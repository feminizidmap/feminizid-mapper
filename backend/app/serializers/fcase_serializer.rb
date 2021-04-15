# frozen_string_literal: true

class FcaseSerializer
  include JSONAPI::Serializer
  attributes :ident

  has_many :victims
  has_many :perpetrators
end

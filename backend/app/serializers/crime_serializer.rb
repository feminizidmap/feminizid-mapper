# frozen_string_literal: true

class CrimeSerializer
  include JSONAPI::Serializer
  attributes :address

  belongs_to :fcase
  has_many :victims
  has_many :perpetrators
end

# frozen_string_literal: true

class PerpetratorSerializer
  include JSONAPI::Serializer
  attributes :age, :citizenship

  belongs_to :fcase
  has_many :victims

  attribute :full_name do |object|
    "#{object.firstname} #{object.lastname}".strip
  end
end

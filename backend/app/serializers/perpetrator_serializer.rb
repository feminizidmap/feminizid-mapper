# frozen_string_literal: true

class PerpetratorSerializer
  include JSONAPI::Serializer
  attributes :age, :citizenship

  belongs_to :fcase

  attribute :full_name do |object|
    "#{object.firstname} #{object.lastname}"
  end
end

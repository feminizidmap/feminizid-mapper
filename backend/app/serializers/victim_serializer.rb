# frozen_string_literal: true

class VictimSerializer
  include JSONAPI::Serializer
  attributes :age

  belongs_to :fcase

  attribute :full_name do |object|
    "#{object.firstname} #{object.lastname}"
  end
end

# frozen_string_literal: true

class VictimSerializer
  include JSONAPI::Serializer
  attributes :age

  attribute :full_name do |object|
    "#{object.firstname} #{object.lastname}"
  end
end

# frozen_string_literal: true

class VictimSerializer < ActiveModel::Serializer
  attributes  :id,
              :age,
              :full_name

  def full_name
    "#{object.firstname} #{object.lastname}".strip
  end
end

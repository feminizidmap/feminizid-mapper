# frozen_string_literal: true

FactoryBot.define do
  factory :change do
    user { nil }
    status { :created }
  end
end

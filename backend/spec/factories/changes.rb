# frozen_string_literal: true

FactoryBot.define do
  factory :change do
    user { association :user }
    record { association :record }
    status { :created }
  end
end

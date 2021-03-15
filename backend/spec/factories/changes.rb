# frozen_string_literal: true

FactoryBot.define do
  factory :change do
    user { association :user }
    status { :created }
  end
end

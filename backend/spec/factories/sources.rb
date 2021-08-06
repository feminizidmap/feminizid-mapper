# frozen_string_literal: true

FactoryBot.define do
  factory :source do
    record { association :record }
    url { Faker::Internet.url }
  end
end

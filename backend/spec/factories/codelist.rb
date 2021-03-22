# frozen_string_literal: true

FactoryBot.define do
  factory :codelist do
    sequence(:identifier, 100) { |n| n }
    name { Faker::Lorem.word }
    lang { 'en' }
    description { Faker::Lorem.sentence }
  end
end

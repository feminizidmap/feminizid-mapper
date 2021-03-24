# frozen_string_literal: true

FactoryBot.define do
  factory :codelist_item do
    sequence(:identifier, 100) { |n| n }
    codelist
    name { Faker::Gender.type }
    lang { 'en' }
    description { Faker::Lorem.sentence }
  end
end

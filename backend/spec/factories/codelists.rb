# frozen_string_literal: true

FactoryBot.define do
  factory :codelist do
    code { 'gender_identity' }
    name { Faker::Gender.type }
    lang { 'en' }
    description { Faker::Lorem.sentence }
  end
end

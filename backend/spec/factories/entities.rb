# frozen_string_literal: true

FactoryBot.define do
  factory :entity do
    record { association :record }
    name { 'Victim' }
    slug { 'victim' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :field do
    entity { association :entity }
    name { 'Address' }
    key { 'address' }
    value { 'Goethestr. 24' }
  end
end

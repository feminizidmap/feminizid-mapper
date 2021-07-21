# frozen_string_literal: true

FactoryBot.define do
  factory :category_item do
    category { association :category }
    name { 'bar' }
  end
end

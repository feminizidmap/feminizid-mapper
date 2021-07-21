# frozen_string_literal: true

FactoryBot.define do
  factory :attribute do
    entity { association :entity }
    category { association :category }
    category_item { association :category_item }
  end
end

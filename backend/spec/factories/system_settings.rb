# frozen_string_literal: true

FactoryBot.define do
  factory :system_setting do
    key { 'settings_alphabet' }
    value { %i[a b c] }
  end
end

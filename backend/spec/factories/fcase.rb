# frozen_string_literal: true

FactoryBot.define do
  factory :fcase do
    ident { "#{Time.zone.now.strftime('%Y-%m-%d')}-Buxtehude" }
  end
end

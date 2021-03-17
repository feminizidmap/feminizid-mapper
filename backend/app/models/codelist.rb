# frozen_string_literal: true

class Codelist < ApplicationRecord
  include ActiveModel::Serializers::JSON

  validates :code, presence: true
  validates :name, presence: true
  validates :lang, presence: true
  validates :lang, length: { is: 2 }
  validate :language_must_be_known

  def language_must_be_known
    errors.add(:lang, 'does not exist') unless LanguageList::LanguageInfo.find(lang)
  end
end

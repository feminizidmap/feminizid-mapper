# frozen_string_literal: true

class CodelistItem < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :codelist

  validates :identifier, presence: true
  validates :name, presence: true
  validates :lang, presence: true
  validates :lang, length: { is: 2 }
  validate :language_must_be_known

  scope :by_language, ->(language) { where(lang: language) }
  scope :by_identifier, ->(ident) { where(identifier: ident) }

  private

  def language_must_be_known
    errors.add(:lang, 'does not exist') unless LanguageList::LanguageInfo.find(lang)
  end
end

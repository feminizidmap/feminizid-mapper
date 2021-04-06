# frozen_string_literal: true

class Codelist < ApplicationRecord
  include ActiveModel::Serializers::JSON

  has_many :codelist_items, dependent: :destroy

  validates :identifier, presence: true
  validates :name, presence: true
  validates :description, length: { minimum: 0, allow_nil: false, message: "can't be nil" }
  validates :lang, presence: true
  validates :lang, length: { is: 2 }
  validate :language_must_be_known

  scope :by_language, ->(language) { where(lang: language) }
  scope :by_identifier, ->(ident) { where(identifier: ident) }

  def items
    codelist_items
  end

  private

  def language_must_be_known
    errors.add(:lang, 'does not exist') unless LanguageList::LanguageInfo.find(lang)
  end
end

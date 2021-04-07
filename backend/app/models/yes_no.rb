# frozen_string_literal: true

class YesNo < ApplicationRecord
  enum answer: { yes: 0, no: 1, unknown: 2, not_applicable: 3 }

  validates :answer, presence: true

  scope :is_yes, -> { where(answer: :yes) }
  scope :is_no, -> { where(answer: :no) }
  scope :is_unknown, -> { where(answer: :unknown) }
  scope :is_not_applicable, -> { where(answer: :not_applicable) }

  scope :is, ->(answer) { where(answer: answer) }
end

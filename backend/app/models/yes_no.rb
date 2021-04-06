# frozen_string_literal: true

class YesNo < ApplicationRecord
  enum answer: { yes: 0, no: 1, unknown: 2, not_applicable: 3 }
end

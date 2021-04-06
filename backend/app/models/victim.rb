# frozen_string_literal: true

class Victim < ApplicationRecord
  include ActiveModel::Serializers::JSON

  enum drunk: { yes: 0, no: 1, unknown: 2, not_applicable: 3 }
  enum drug_influence: { yes: 0, no: 1, unknown: 2, not_applicable: 3 }
  enum previous_reports_of_violence: { yes: 0, no: 1, unknown: 2, not_applicable: 3 }

  has_one :civil_status, through: :civil_status_id, class_name: 'CodelistItem'
  has_one :educational_background, through: :educational_background_id, class_name: 'CodelistItem'
  has_one :citizenship_type, through: :citizenship_type_id, class_name: 'CodelistItem'
  has_one :legal_status, through: :legal_status_id, class_name: 'CodelistItem'
end

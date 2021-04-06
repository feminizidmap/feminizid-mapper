# frozen_string_literal: true

class Victim < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :drunk, class_name: 'YesNo', optional: true
  belongs_to :drug_influence, class_name: 'YesNo', optional: true
  belongs_to :previous_reports_of_violence, class_name: 'YesNo', optional: true

  has_one :civil_status, through: :civil_status_id, class_name: 'CodelistItem'
  has_one :educational_background, through: :educational_background_id, class_name: 'CodelistItem'
  has_one :citizenship_type, through: :citizenship_type_id, class_name: 'CodelistItem'
  has_one :legal_status, through: :legal_status_id, class_name: 'CodelistItem'

  accepts_nested_attributes_for :drunk
  accepts_nested_attributes_for :drug_influence
  accepts_nested_attributes_for :previous_reports_of_violence
end

# frozen_string_literal: true

class Victim < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :fcase

  belongs_to :drunk, class_name: 'YesNo', optional: true
  belongs_to :drug_influence, class_name: 'YesNo', optional: true
  belongs_to :previous_reports_of_violence, class_name: 'YesNo', optional: true

  belongs_to :civil_status, class_name: 'CodelistItem', optional: true
  belongs_to :educational_background, class_name: 'CodelistItem', optional: true
  belongs_to :citizenship_type, class_name: 'CodelistItem', optional: true
  belongs_to :legal_status, class_name: 'CodelistItem', optional: true

  accepts_nested_attributes_for :drunk
  accepts_nested_attributes_for :drug_influence
  accepts_nested_attributes_for :previous_reports_of_violence

  scope :by_drunk_answer, ->(answer) { Victim.joins(:drunk).merge(YesNo.is(answer)) }
  scope :by_drug_answer, ->(answer) { Victim.joins(:drug_influence).merge(YesNo.is(answer)) }
  scope :by_reports_answer, ->(answer) { Victim.joins(:previous_reports_of_violence).merge(YesNo.is(answer)) }

  scope :by_civil_status, ->(name) { Victim.joins(:civil_status).merge(CodelistItem.by_name(name)) }
  scope :by_educational_background, ->(name) { Victim.joins(:educational_background).merge(CodelistItem.by_name(name)) }
  scope :by_citizenship_type, ->(name) { Victim.joins(:citizenship_type).merge(CodelistItem.by_name(name)) }
  scope :by_legal_status, ->(name) { Victim.joins(:legal_status).merge(CodelistItem.by_name(name)) }
end

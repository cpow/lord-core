class LeasePaymentReminder < ApplicationRecord
  REMINDER_TYPE_DUE_NOW = 'due_now'.freeze
  REMINDER_TYPE_DUE_SOON = 'due_soon'.freeze

  REMINDER_TYPES = [
    REMINDER_TYPE_DUE_NOW,
    REMINDER_TYPE_DUE_SOON
  ].freeze

  belongs_to :lease_payment

  validates :reminder_type, presence: true, inclusion: { in: REMINDER_TYPES }
end

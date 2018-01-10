# == Schema Information
#
# Table name: lease_payment_reminders
#
#  id               :integer          not null, primary key
#  email_text       :text
#  reminder_type    :string           not null
#  lease_payment_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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

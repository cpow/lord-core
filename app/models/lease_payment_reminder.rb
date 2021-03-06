# == Schema Information
#
# Table name: lease_payment_reminders
#
#  id               :bigint(8)        not null, primary key
#  email_text       :text
#  reminder_type    :string           not null
#  lease_payment_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class LeasePaymentReminder < ApplicationRecord
  REMINDER_TYPE_DUE_NOW = 'due_now'.freeze
  REMINDER_TYPE_DUE_SOON = 'due_soon'.freeze
  REMINDER_TYPE_DUE_LATE = 'late'.freeze

  REMINDER_TYPES = [
    REMINDER_TYPE_DUE_NOW,
    REMINDER_TYPE_DUE_LATE,
    REMINDER_TYPE_DUE_SOON
  ].freeze

  belongs_to :lease_payment
  has_many :events, as: :eventable

  validates :reminder_type, presence: true, inclusion: { in: REMINDER_TYPES }

  def formatted_created_at
    created_at.strftime('%B %d, %Y')
  end
end

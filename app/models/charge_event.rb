# == Schema Information
#
# Table name: charge_events
#
#  id               :bigint(8)        not null, primary key
#  stripe_charge_id :string
#  event_type       :string
#  stripe_event_id  :string
#  failure_code     :string
#  failure_message  :string
#  payment_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ChargeEvent < ApplicationRecord
  PENDING_TYPE = 'charge.pending'.freeze
  FAILURE_TYPE = 'charge.failed'.freeze
  SUCCEEDED_TYPE = 'charge.succeeded'.freeze
  CREATED_TYPE = 'charge.created'.freeze

  EVENT_TYPES = [PENDING_TYPE,
                 FAILURE_TYPE,
                 SUCCEEDED_TYPE,
                 CREATED_TYPE].freeze

  validates :event_type, inclusion: { in: EVENT_TYPES }
  validates :stripe_charge_id, presence: true

  belongs_to :payment
end

# == Schema Information
#
# Table name: payments
#
#  id                :integer          not null, primary key
#  amount            :integer
#  amount_refunded   :integer
#  unit_id           :integer
#  lease_payment_id  :integer
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_charge_id  :string
#  latest_event_type :string
#

class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :lease_payment, optional: true
  belongs_to :unit, optional: true
  has_many :charge_events
  has_many :events, as: :eventable
  has_many :line_items, as: :itemable

  validates :stripe_charge_id, presence: true

  def human_amount
    return 0 if latest_event_type == ChargeEvent::FAILURE_TYPE
    original_amount
  end

  def original_amount
    amount && amount / 100
  end

  def description
    "#{user.email}, for unit: #{unit.name}. In property #{unit.property.name}"
  end

  def human_event_type
    latest_event_type.split('charge.').last
  end
end

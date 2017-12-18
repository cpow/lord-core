# == Schema Information
#
# Table name: leases
#
#  id                      :integer          not null, primary key
#  start_date              :datetime
#  end_date                :datetime
#  payment_first_date      :datetime
#  payment_amount          :integer
#  payment_days_until_late :integer
#  payment_reminder_days   :integer
#  unit_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  payment_id              :integer
#

class Lease < ApplicationRecord
  belongs_to :unit

  has_many :payments
  has_many :lease_payments

  validates :payment_first_date,
            :payment_days_until_late,
            :payment_reminder_days, presence: true

  validates :payment_days_until_late,
            numericality: {
              less_than: 15,
              message: 'must be within two weeks'
            }

  def mark_next_active_from_date(date)
    lease_payment = next_lease_payment_from_date(date)
    lease_payment&.update_attributes!(active: true)
  end

  def next_lease_payment_from_date(date)
    lease_payments.where("due_date > ?", date).first
  end
end

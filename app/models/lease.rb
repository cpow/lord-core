class Lease < ApplicationRecord
  belongs_to :unit
  has_many :payments
  has_many :scheduled_payments

  validates :payment_first_date,
            :payment_days_until_late,
            :payment_reminder_days, presence: true

  validates :payment_days_until_late,
            numericality: {
              less_than: 15,
              message: 'must be within two weeks'
            }
end

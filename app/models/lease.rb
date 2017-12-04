class Lease < ApplicationRecord
  belongs_to :unit
  has_many :payments

  validates :payment_first_date, presence: true
  validates :payment_days_until_late,
            numericality: {
              less_than: 15,
              message: 'must be within two weeks'
            }

  def total_due

  end
end

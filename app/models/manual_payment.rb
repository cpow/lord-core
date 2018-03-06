class ManualPayment < ApplicationRecord
  belongs_to :lease_payment

  validates :description, :amount, presence: true
  validates :amount, numericality: true

  before_save :multiply_amount

  def multiply_amount
    self.amount *= 100
  end

  def human_amount
    amount && amount / 100
  end
end

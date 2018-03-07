class ManualPayment < ApplicationRecord
  belongs_to :lease_payment
  belongs_to :user

  validates :description, :amount, presence: true
  validates :amount, numericality: true
  validates :user, presence: true

  before_save :multiply_amount

  def multiply_amount
    self.amount *= 100
  end

  def human_amount
    amount && amount / 100
  end
end

# == Schema Information
#
# Table name: manual_payments
#
#  id               :bigint(8)        not null, primary key
#  lease_payment_id :bigint(8)
#  amount           :integer
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint(8)
#

class ManualPayment < ApplicationRecord
  belongs_to :lease_payment
  belongs_to :user

  has_many :manual_payment_receipts, dependent: :destroy
  has_many :line_items, as: :itemable

  delegate :unit, to: :lease_payment

  accepts_nested_attributes_for :manual_payment_receipts

  validates :amount, presence: true
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

# == Schema Information
#
# Table name: lease_payments
#
#  id            :integer          not null, primary key
#  company_id    :integer          not null
#  unit_id       :integer          not null
#  lease_id      :integer          not null
#  due_date      :datetime
#  reminder_date :datetime
#  past_due_date :datetime
#  active        :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class LeasePayment < ApplicationRecord
  default_scope { order(due_date: :asc) }
  scope :active, -> { where(active: true) }

  has_many :payments
  has_many :users, through: :payment

  belongs_to :lease
  belongs_to :unit

  def amount_due
    lease.payment_amount - payments.sum(:amount)
  end
end

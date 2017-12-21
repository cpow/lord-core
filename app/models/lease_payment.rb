# == Schema Information
#
# Table name: lease_payments
#
#  id            :integer          not null, primary key
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

  validates :due_date, :past_due_date, :reminder_date, presence: true

  SECONDS_IN_DAY = 86_400

  def deal_with_payment
    if human_amount_due <= 0
      update_attributes!(active: false)
      lease.mark_next_active_from_date(self.due_date)
    else
      true
    end
  end

  def formatted_due_date
    due_date.strftime('%B %d, %Y')
  end

  def human_amount_due
    amount_due / 100
  end

  def paid_in_full?
    amount_due <= 0
  end

  def amount_due
    (lease.payment_amount - payments.sum(:amount))
  end

  def payment_late?
    Time.zone.now.beginning_of_day > due_date.beginning_of_day
  end

  def payment_within_reminder_period?
    !payment_late? && !payment_due? && \
      Time.zone.now.beginning_of_day >= reminder_date.beginning_of_day
  end

  def payment_due?
    Time.zone.now.beginning_of_day >= due_date.beginning_of_day
  end

  def due_in_days
    ((due_date.beginning_of_day - Time.zone.now.beginning_of_day) / SECONDS_IN_DAY)
      .floor
  end
end

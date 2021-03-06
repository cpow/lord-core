# == Schema Information
#
# Table name: lease_payments
#
#  id            :bigint(8)        not null, primary key
#  unit_id       :integer          not null
#  lease_id      :integer          not null
#  due_date      :datetime
#  reminder_date :datetime
#  past_due_date :datetime
#  active        :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  local_amount  :integer
#

class LeasePayment < ApplicationRecord
  default_scope { order(due_date: :asc) }
  scope :active, -> { where(active: true) }

  has_many :payments
  has_many :manual_payments

  has_many :users, through: :unit
  has_many :lease_payment_reminders
  has_many :events, as: :eventable

  belongs_to :lease
  belongs_to :unit

  validates :due_date, :past_due_date, :reminder_date, presence: true

  SECONDS_IN_DAY = 86_400

  def payment_amount
    local_amount || lease.payment_amount
  end

  # TODO: handle the negative form of this. update to active, and de-activate
  # the next payment
  def deal_with_payment
    if human_amount_due <= 0
      update_attributes!(active: false)
      lease.mark_next_active_from_date(self.due_date)
    else
      true
    end
  end

  def human_local_amount
    local_amount.present? ? local_amount / 100 : 0
  end

  def human_payment_amount
    payment_amount / 100
  end

  def manual_total
    manual_payments.sum(:amount)
  end

  def payment_total
    payments.successful.sum(:amount)
  end

  def manual_with_online_payment_total
    manual_total + payment_total
  end

  def users
    unit.users
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
    (payment_amount - payment_total - manual_total)
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

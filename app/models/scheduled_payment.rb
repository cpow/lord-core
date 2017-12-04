class ScheduledPayment < ApplicationRecord
  default_scope { order(due_date: :asc) }

  has_many :users, through: :payment
  belongs_to :lease
  belongs_to :unit
  belongs_to :company
end

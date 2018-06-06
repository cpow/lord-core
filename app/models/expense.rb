class Expense < ApplicationRecord
  belongs_to :expenseable, polymorphic: true
  belongs_to :company

  EXPENSEABLE_TYPES = %w[Unit Property Issue].freeze

  def human_amount
    amount && amount / 100
  end
end

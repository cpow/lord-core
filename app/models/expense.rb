class Expense < ApplicationRecord
  belongs_to :expenseable, polymorphic: true
  belongs_to :company

  EXPENSEABLE_TYPES = %w[Unit Property Issue].freeze
end

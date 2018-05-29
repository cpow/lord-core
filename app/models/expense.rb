class Expense < ApplicationRecord
  belongs_to :expenseable, polymorphic: true
end

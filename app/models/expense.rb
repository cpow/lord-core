# == Schema Information
#
# Table name: expenses
#
#  id               :bigint(8)        not null, primary key
#  amount           :integer
#  description      :text
#  expenseable_type :string
#  expenseable_id   :bigint(8)
#  company_id       :bigint(8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Expense < ApplicationRecord
  belongs_to :expenseable, polymorphic: true
  belongs_to :company

  attribute :changing_expenseable_type, :boolean

  EXPENSEABLE_TYPES = %w[Unit Property Issue].freeze

  def human_amount
    amount && amount / 100
  end
end

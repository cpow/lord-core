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

require 'rails_helper'

RSpec.describe Expense, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

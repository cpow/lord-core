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

require 'rails_helper'

RSpec.describe ManualPayment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

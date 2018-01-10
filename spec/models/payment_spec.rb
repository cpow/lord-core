# == Schema Information
#
# Table name: payments
#
#  id               :integer          not null, primary key
#  amount           :integer
#  amount_refunded  :integer
#  unit_id          :integer
#  lease_payment_id :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  stripe_charge_id :string
#

require 'rails_helper'

RSpec.describe Payment, type: :model do
end

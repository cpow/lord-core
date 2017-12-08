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
#

class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :lease_payment
  belongs_to :unit, optional: true
end

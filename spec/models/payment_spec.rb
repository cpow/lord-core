# == Schema Information
#
# Table name: payments
#
#  id                :bigint(8)        not null, primary key
#  amount            :integer
#  amount_refunded   :integer
#  unit_id           :integer
#  lease_payment_id  :integer
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_charge_id  :string
#  latest_event_type :string
#

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe Payment, '.successful' do
    it 'filters out bad boys' do
      bad = create(:payment, :error)
      good = create(:payment)

      expect(Payment.successful).to include(good)
      expect(Payment.successful).to_not include(bad)
    end
  end
end

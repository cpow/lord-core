# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  invite_token           :string
#  invited_by_id          :integer
#  invite_date            :datetime
#  activated              :boolean          default(FALSE)
#  stripe_account_guid    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  bank_account_guid      :string
#  bank_account_last4     :string
#  bank_account_name      :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should do something' do
    user = create(:user)
    expect(user).to be
  end

  describe '#has_lease?' do
    it 'should return false if the lease is a null lease' do
      expect(described_class.new.has_lease?).to be_falsey
    end

    it 'should return true if a user has a lease' do
      residency = create(:residency)
      create(:lease, unit: residency.unit)
      user = residency.user
      expect(user.has_lease?).to be_truthy
    end
  end

  context '#current_lease_payment' do
    it 'should return a null lease payment if there is nothing' do
      user = create(:user)

      expect(user.current_lease_payment).to be_instance_of(NullLeasePayment)
    end

    it 'should return lease payment when active lease and payment is there' do
      residency = create(:residency)
      lease_payment = create(:lease_payment, unit: residency.unit, active: true)
      user = residency.user

      expect(user.current_lease_payment).to eq(lease_payment)
    end
  end

  describe '#needs_to_sign_up_for_plaid?' do
    it 'is false when guid is present' do
      user = create(:user, stripe_account_guid: 'something')
      expect(user.needs_to_sign_up_for_plaid?).to be_falsey
    end

    it 'is true when guid is not present' do
      user = create(:user)
      expect(user.needs_to_sign_up_for_plaid?).to be_truthy
    end
  end

  context '#current_human_amount_owed' do
    it 'should return a 0 if there is nothing' do
      user = create(:user)

      expect(user.current_human_amount_owed).to eq(0)
    end

    it 'should return lease amount if lease and current payment' do
      user = create(:user)

      expect(user.current_human_amount_owed).to eq(0)
    end
  end
end

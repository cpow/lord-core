require 'rails_helper'
RSpec.describe UserDashboardHelper, type: :helper do
  describe '#plaid_card_class' do
    it 'should return warning class if needs to sign up' do
      @user = create(:user)
      expect(plaid_card_class).to eq(described_class::WARNING_CLASS)
    end

    it 'should return nothing class if not needs to sign up' do
      @user = create(:user, stripe_account_guid: 'something')
      expect(plaid_card_class).to eq('')
    end
  end
end

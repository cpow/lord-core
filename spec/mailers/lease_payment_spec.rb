require 'rails_helper'

RSpec.describe LeasePaymentMailer, type: :mailer do
  it 'should email to one user' do
    user = create(:user, :with_reminder_lease_payment)
    lease_payment = user.current_lease_payment
    mailer = described_class.remind_tenants_lease_is_due(
      lease_payment, user.email
    )

    expect(mailer.to).to eq([user.email])
  end
end

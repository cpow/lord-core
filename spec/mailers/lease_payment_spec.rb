require 'rails_helper'

RSpec.describe LeasePaymentMailer, type: :mailer do
  it 'should email to one user' do
    user = create(:user, :with_reminder_lease_payment)
    lease_payment = user.current_lease_payment
    mailer = described_class.remind_tenants_lease_is_due(lease_payment)

    expect(mailer.to).to eq([user.email])
    expect(mailer.bcc).to be_empty
  end

  it 'should email to multiple users if multiple users see lease' do
    user = create(:user, :with_reminder_lease_payment)
    residency = user.residencies.last
    user2 = create(:user)
    create(:residency,
           property: residency.property,
           unit: residency.unit,
           user: user2)
    lease_payment = user.current_lease_payment

    mailer = described_class.remind_tenants_lease_is_due(lease_payment)

    expect(mailer.to).to eq([user.email])
    expect(mailer.bcc).to eq([user2.email])
  end
end

require 'rails_helper'

RSpec.describe InviteUserToPropertyMailer, type: :mailer do
  it 'should send to the resident\'s user email' do
    residency = create(:residency)
    create(:property_manager, company: residency.company)

    expect do
      described_class.invite(residency).deliver_now
    end.to change(ActionMailer::Base.deliveries, :count).by(1)
  end

  it 'should come from the first property manager\'s email' do
    residency = create(:residency)
    manager = create(:property_manager, company: residency.company)

    mail = described_class.invite(residency).deliver_now

    expect(mail.from).to eq([manager.email])
  end
end

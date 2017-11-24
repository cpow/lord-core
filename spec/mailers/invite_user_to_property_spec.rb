require 'rails_helper'

RSpec.describe InviteUserToPropertyMailer, type: :mailer do
  it 'should send to the resident\'s user email' do
    residency = create(:residency)
    expect do
      described_class.invite(residency).deliver_now
    end.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end

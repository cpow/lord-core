require 'rails_helper'

describe LeasePayment::RemindUsers do
  describe '.rent_is_due' do
    it 'should send an email when lease_payments are there' do
      tenant = create(:user, :with_residence)
      lease_payment = create(:lease_payment, unit: tenant.units.first)

      allow(LeasePaymentQuery).to\
        receive_message_chain(:new,
                              :search,
                              :for_currently_due,
                              :for_no_reminders) do
                                LeasePayment.where(id: lease_payment.id)
                              end

      expect do
        described_class.rent_is_due
      end.to have_enqueued_job(ActionMailer::DeliveryJob)
    end
  end
end

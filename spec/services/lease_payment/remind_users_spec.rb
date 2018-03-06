require 'rails_helper'

describe LeasePayment::RemindUsers do
  describe '.rent_is_late' do
    it 'should send an email when lease_payments are there' do
      tenant = create(:user, :with_residence)
      lease_payment = create(:lease_payment, unit: tenant.units.first)

      allow(LeasePaymentQuery).to\
        receive_message_chain(:new,
                              :search,
                              :for_currently_late,
                              :for_no_reminders_of_type) do
                                LeasePayment.where(id: lease_payment.id)
                              end

      expect do
        described_class.rent_is_late
      end.to have_enqueued_job(ActionMailer::DeliveryJob)
    end
  end

  describe '.rent_is_due' do
    it 'should send an email when lease_payments are there' do
      tenant = create(:user, :with_residence)
      lease_payment = create(:lease_payment, unit: tenant.units.first)

      allow(LeasePaymentQuery).to\
        receive_message_chain(:new,
                              :search,
                              :for_currently_due,
                              :for_no_reminders_of_type) do
                                LeasePayment.where(id: lease_payment.id)
                              end

      expect do
        described_class.rent_is_due
      end.to have_enqueued_job(ActionMailer::DeliveryJob)
    end

    it 'should create a reminder for history' do
      payment_reminder_type = LeasePaymentReminder::REMINDER_TYPE_DUE_NOW
      tenant = create(:user, :with_residence)
      lease_payment = create(:lease_payment, unit: tenant.units.first)

      allow(LeasePaymentQuery).to\
        receive_message_chain(:new,
                              :search,
                              :for_currently_due,
                              :for_no_reminders_of_type) do
                                LeasePayment.where(id: lease_payment.id)
                              end

      described_class.rent_is_due

      lease_payment_reminder = LeasePaymentReminder.last

      expect(lease_payment_reminder).to be
      expect(lease_payment_reminder.reminder_type).to eq(payment_reminder_type)
    end
  end
end

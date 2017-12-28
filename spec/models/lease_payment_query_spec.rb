require 'rails_helper'

describe LeasePaymentQuery do
  describe '.initialize' do
    it 'should return all lease payments' do
      lease_payment = create(:lease_payment)
      expect(described_class.new.relation).to include(lease_payment)
    end
  end

  context 'within search' do
    context 'chaining together searches' do
      it 'should work for currently due with no reminders' do
        create(:lease_payment, :late)
        payment = create(:lease_payment, :due_today)
        query = described_class.new

        expect(query.search.for_currently_due.count).to eq(1)
        expect(query.search.for_currently_due).to include(payment)

        chained_search = query.search.for_currently_due

        expect(chained_search.for_no_reminders).to include(payment)
      end
    end

    describe '#for_currently_due' do
      it 'should return only lease payments that are due' do
        create(:lease_payment, :late)
        payment = create(:lease_payment, :due_today)
        query = described_class.new

        expect(query.search.for_currently_due.count).to eq(1)
        expect(query.search.for_currently_due).to include(payment)
      end
    end

    describe '#for_no_reminders_of_type' do
      it 'should not return lease payments that have reminders of a type' do
        reminder_type = LeasePaymentReminder::REMINDER_TYPE_DUE_SOON
        lease_payment = create(:lease_payment)
        create(:lease_payment_reminder,
               reminder_type: reminder_type,
               lease_payment: lease_payment)

        query = described_class.new
        result = query.search.for_no_reminders_of_type(reminder_type)

        expect(result.length).to eq(0)
      end

      it 'should return lease payments that don\'t have the reminder type' do
        reminder_type = LeasePaymentReminder::REMINDER_TYPE_DUE_NOW
        search_type = LeasePaymentReminder::REMINDER_TYPE_DUE_SOON
        lease_payment = create(:lease_payment)
        create(:lease_payment_reminder,
               reminder_type: reminder_type,
               lease_payment: lease_payment)

        query = described_class.new
        result = query.search.for_no_reminders_of_type(search_type)

        expect(result.length).to eq(1)
      end
    end

    describe '#for_no_reminders' do
      it 'should return 1 lease payment with no reminder' do
        lease_payment = create(:lease_payment)
        query = described_class.new

        expect(query.search.for_no_reminders).to include(lease_payment)
      end

      it 'should not return any non active lease payments' do
        lease_payment = create(:lease_payment, active: false)
        query = described_class.new

        expect(query.search.for_no_reminders.length).to eq(0)
      end

      it 'should not return any lease payments that have a reminder' do
        create(:lease_payment, :has_been_reminded)
        query = described_class.new

        expect(query.search.for_no_reminders.length).to eq(0)
      end
    end
  end
end

require 'rails_helper'

describe LeasePayment do
  before(:each) do
    Timecop.freeze(Time.zone.now.beginning_of_day)
  end

  describe 'due_in_days' do
    it 'should retun number of days due with current time' do
      time = (Time.zone.now + 10.days).end_of_day

      payment = build(:lease_payment, due_date: time)
      expect(payment.due_in_days).to eq(10)
    end
  end

  describe 'payment_within_reminder_period?' do
    it 'returns true when within number of days to remind tenant' do
      payment = build(:lease_payment, reminder_date: Time.zone.now)

      expect(payment.payment_within_reminder_period?).to be_truthy
    end

    it 'returns false when payment is already late' do
      payment = build(:lease_payment, reminder_date: Time.zone.now)
      expect(payment).to receive(:payment_late?) { true }

      expect(payment.payment_within_reminder_period?).to be_falsey
    end

    it 'returns false when payment is already due' do
      payment = build(:lease_payment, reminder_date: Time.zone.now)
      expect(payment).to receive(:payment_due?) { true }

      expect(payment.payment_within_reminder_period?).to be_falsey
    end
  end

  describe 'payment_late?' do
    it 'returns true when past due date' do
      time = (Time.zone.now - 1.day)
      payment = build(:lease_payment, due_date: time)

      expect(payment.payment_late?).to be_truthy
    end

    it 'returns false when not past due date' do
      time = (Time.zone.now + 1.day)
      payment = build(:lease_payment, due_date: time)

      expect(payment.payment_late?).to be_falsey
    end
  end

  describe 'payment_due?' do
    it 'returns true when current date' do
      time = Time.zone.now
      payment = build(:lease_payment, due_date: time)

      expect(payment.payment_due?).to be_truthy
    end
  end
end

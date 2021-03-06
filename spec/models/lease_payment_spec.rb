# == Schema Information
#
# Table name: lease_payments
#
#  id            :bigint(8)        not null, primary key
#  unit_id       :integer          not null
#  lease_id      :integer          not null
#  due_date      :datetime
#  reminder_date :datetime
#  past_due_date :datetime
#  active        :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  local_amount  :integer
#

require 'rails_helper'

describe LeasePayment do
  before(:each) do
    Timecop.freeze(Time.zone.now.beginning_of_day)
  end

  describe 'local_amount' do
    it 'should override the amount of lease' do
      lease = create(:lease, payment_amount: 10000)
      lease_payment = create(:lease_payment, lease: lease, local_amount: 50)

      expect(lease_payment.payment_amount).to eq(50)
    end

    it 'should be nil and rever to lease amount' do
      lease = create(:lease, payment_amount: 10000)
      lease_payment = create(:lease_payment, lease: lease)

      expect(lease_payment.payment_amount).to eq(10000)
    end
  end

  describe 'deal_with_payment' do
    it 'should mark lease_payment as inactive if payments sum amt due' do
      lease = create(:lease, payment_amount: 10000)
      lease_payment = create(:lease_payment, lease: lease)

      create(:payment, lease_payment: lease_payment, amount: 10000)

      lease_payment.deal_with_payment

      expect(lease_payment.active).to be_falsey
    end

    it 'should leave lease payment as active when total is less than pymt' do
      lease = create(:lease, payment_amount: 10000)
      lease_payment = create(:lease_payment, lease: lease)

      create(:payment, lease_payment: lease_payment, amount: 2500)

      lease_payment.deal_with_payment

      expect(lease_payment.active).to be_truthy
      expect(lease_payment.human_amount_due).to eq(75)
    end

    it 'should make the next lease payment active' do
      lease = create(:lease, payment_amount: 10000)
      lease_payment = create(:lease_payment, lease: lease)
      lease_payment_2 = create(:lease_payment,
                      lease: lease,
                      due_date: Time.now.beginning_of_day + 2.days
                     )

      create(:payment, lease_payment: lease_payment, amount: 10000)

      lease_payment.deal_with_payment

      expect(lease_payment_2.active).to be_truthy
    end
  end

  describe 'due_in_days' do
    it 'should retun number of days due with current time' do
      time = (Time.zone.now + 10.days).end_of_day

      payment = build(:lease_payment, due_date: time)
      expect(payment.due_in_days).to eq(10)
    end

    it 'should gracefully handle 0 days due' do
      time = Time.zone.now

      payment = build(:lease_payment, due_date: time)
      expect(payment.due_in_days).to eq(0)
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

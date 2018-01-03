require 'rails_helper'

describe LeasePayment::CreateFromLease do
  describe '#new' do
    it 'should initialize properly' do
      lease = create(:lease)
      generator = described_class.new(lease: lease)

      expect(generator.lease).to eq(lease)
    end
  end

  describe '#create_payments' do
    it 'should create 4 payments for 4 months' do
      Timecop.freeze(Time.zone.now.beginning_of_day)
      start_date = Time.now
      end_date = start_date + 3.months
      lease = create(:lease, start_date: start_date, end_date: end_date)

      expect do
        described_class.new(lease: lease).create_payments
      end.to change(LeasePayment, :count).by(4)
    end

    it 'should set first payment as active' do
      start_date = Time.zone.now
      end_date = start_date + 3.months
      lease = create(:lease, payment_first_date: start_date, end_date: end_date)

      described_class.new(lease: lease).create_payments

      expect(lease.lease_payments.first.active).to be
    end
  end
end

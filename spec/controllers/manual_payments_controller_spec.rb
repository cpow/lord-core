require 'rails_helper'

RSpec.describe ManualPaymentsController, type: :controller do
  describe '#create' do
    context 'when signed in' do
      it 'should multiply the amount due to cents' do
        sign_in(create(:property_manager, :with_company))
        lease = create(:lease, :with_payment)
        lp = lease.lease_payments.last
        amount = 100

        post :create, params: {
          lease_payment_id: lp.id,
          manual_payment: {
            amount: amount, description: 'check'
          }
        }

        manual = ManualPayment.last

        expect(manual.amount).to eq(amount * 100)
      end

      it 'should update the lease_payment' do
        sign_in(create(:property_manager, :with_company))
        lease = create(:lease, :with_payment)
        lp = lease.lease_payments.last

        post :create, params: {
          lease_payment_id: lp.id,
          manual_payment: {
            amount: 100, description: 'check'
          }
        }

        manual = ManualPayment.last

        expect(response).to be_redirect
        expect(lp.amount_due).to eq(lease.payment_amount - manual.amount)
      end
    end
  end
end

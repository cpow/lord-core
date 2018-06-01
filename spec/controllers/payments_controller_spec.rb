require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe 'POST #create' do
    context 'when not signed in' do
      it 'should redirect or something' do
        post :create, params: { payment: { amount: 100 } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when signed in' do
      it 'should multiple entered payment by 100 (for cents)' do
        user = create(:user, :with_residence, :with_stripe_account)
        sign_in(user)
        amount_paid = 100
        lease = create(:lease)
        lp = create(:lease_payment, lease: lease)

        post :create, params: { payment: { amount: amount_paid, lease_payment_id: lp.id } }

        expect(Payment.last.amount).to eq(amount_paid * 100)
      end

      it 'should store the stripe charge id locally and make lineitem' do
        user = create(:user, :with_residence, :with_stripe_account)
        sign_in(user)
        amount_paid = 100
        lease = create(:lease)
        lp = create(:lease_payment, lease: lease)

        expect do
          post :create, params: {
            payment: {
              amount: amount_paid,
              lease_payment_id: lp.id
            }
          }
        end.to change(LineItem, :count).by(1)

        expect(Payment.last.stripe_charge_id).to_not be_empty
      end
    end
  end
end

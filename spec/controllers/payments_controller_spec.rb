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
        sign_in(create(:user))
        lease = create(:lease)
        lp = create(:lease_payment, lease: lease)

        post :create, params: { payment: { amount: 100, lease_payment_id: lp.id } }
      end
    end
  end
end

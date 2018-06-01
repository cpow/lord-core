require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  describe 'POST #create' do
    it 'should create a new expense and line item' do
      manager = create(:property_manager, :with_company)
      user = create(:user, :with_residence, :with_stripe_account)
      sign_in(manager)

      expect do
        post :create, params: {
          expense: {
            expenseable_type: 'Unit',
            expenseable_id: user.current_unit.id,
            amount: 100,
            description: 'hi',
            company_id: manager.company.id
          }
        }
      end.to change(LineItem, :count).by(1)

      expect(response).to be_redirect
    end
  end
end


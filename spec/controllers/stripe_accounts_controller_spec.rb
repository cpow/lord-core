require 'rails_helper'

RSpec.describe StripeAccountsController, type: :controller do
  describe 'POST #create' do
    it 'should flag company with stripe_problem when more info required' do
      manager = create(:property_manager, :with_company)
      sign_in(manager)

      post :create, params: default_stripe_params

      expect(manager.company.reload.stripe_account_guid).to be_truthy
      expect(manager.company.reload.stripe_problem).to be_truthy
    end

    it 'should create stripe account without issues when everything is good' do
      manager = create(:property_manager, :with_company)
      sign_in(manager)

      post :create, params: default_stripe_params

      expect(manager.company.reload.stripe_account_guid).to be_truthy
    end
  end

  def default_stripe_params
    {
      stripe_account: {
        first_name: 'toph',
        last_name: 'powerson',
        account_type: 'individual',
        dob_day: '23',
        dob_month: '2',
        dob_year: '1985',
        address_line1: '34 brittin ave',
        address_city: 'bridgeport',
        tos: true,
        address_state: 'CT',
        address_postal: '06605',
        ssn_last_4: '8888'
      }
    }
  end
end

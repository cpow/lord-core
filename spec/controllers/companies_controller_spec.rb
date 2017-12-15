require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #new' do
    context 'when not signed in' do
      it 'should return with error' do
        get :new
        expect(response).to redirect_to(new_property_manager_session_path)
      end
    end

    context 'when manager already has a company' do
      it 'should redirect those silly idiots' do
        sign_in(create(:property_manager, :with_company))
        get :new
        expect(response).to redirect_to(authenticated_user_root_path)
      end
    end

    it 'returns http success' do
      sign_in(create(:property_manager))
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'when not signed in' do
      it 'should return with error' do
        post :create, params: { company: { name: 'some stupid company' } }
        expect(response).to redirect_to(new_property_manager_session_path)
      end
    end

    context 'when signed in' do
      it 'creates company. and assigns current pm to it' do
        pm = create(:property_manager)
        sign_in(pm)

        expect do
          post :create, params: { company: { name: 'some stupid company' } }
        end.to(change { Company.count })

        pm.reload

        expect(pm.is_company_admin?).to be_truthy
      end
    end
  end

  describe 'PATCH #update' do
  end
end

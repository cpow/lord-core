require 'rails_helper'

RSpec.describe PropertyManagers::RegistrationsController, type: :controller do
  describe '#create' do
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:property_manager]
    end

    it 'should create a company if manager doesn\'t have one' do
      expect do
        post :create, params: {
          property_manager: {
            password: 'test1234',
            password_conformation: 'test1234',
            email: 'blah@blah.com'
          }
        }
      end.to change(Company, :count).by(1)
    end
  end
end

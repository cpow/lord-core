require 'rails_helper'

RSpec.describe PropertyManagerCreationController, type: :controller do
  describe 'POST #create' do
    it 'should create a property manager with correct params' do
      post :create, params: {
        property_manager: {
          email: 'someone@example.com',
          name: 'bob bobsmith'
        }
      }

      manager = PropertyManager.last

      expect(response).to redirect_to(
        new_property_manager_initializer_path(property_manager_id: manager.id)
      )
      expect(manager.active).to be_falsey
    end
  end
end

require 'rails_helper'

describe Companies::PropertyManagersController do
  context 'signed in as a property manager' do
    describe '#create' do
      it 'should correctly create a property manager' do
        property_manager = create(:property_manager, :with_company)
        sign_in(property_manager)

        params = {
            company_id: property_manager.company_id,
            property_manager: {
                name: 'tophie bear',
                email: 'something_property_manager@example.com',

            }
        }

        expect do
          post :create, params: params
        end.to change(PropertyManager, :count).by(1)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe PropertyManagers::CreateService do
  describe '.handle_callbacks_for' do
    it 'creates a company if property manager doesn\'t have one' do
      manager = create(:property_manager)
      expect do
        described_class.new(property_manager: manager).handle_callbacks!
      end.to change(Company, :count).by(1)

      expect(manager.has_company?).to be_truthy
      expect(manager.is_company_admin?).to be_truthy
    end
  end
end

# == Schema Information
#
# Table name: properties
#
#  id             :integer          not null, primary key
#  address_city   :string           not null
#  address_line1  :string           not null
#  address_state  :string           not null
#  address_postal :string           not null
#  name           :string           not null
#  description    :text
#  company_id     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Property, type: :model do
  describe '#unread_notifications_for' do
    it 'should return notifications unread by a user' do
      manager = create(:property_manager, :with_company)
      property = create(:property, company: manager.company)
      manager2 = create(:property_manager)
      event = create(:event, property: property)
      create(:event_read, event: event, reader: manager2)

      expect(property.unread_notifications_for(manager)).to eq([event])
      expect(property.unread_notifications_for(manager2)).to eq([])

      create(:event_read, event: event, reader: manager)

      expect(property.unread_notifications_for(manager)).to eq([])
    end
  end
end

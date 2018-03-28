require 'rails_helper'

RSpec.describe Notifications::Unread do
  describe '#users' do
    it 'should find users if event has a unit' do
      residency = create(:residency)
      tenant = residency.user
      event = create(:event, unit: residency.unit)

      checker = described_class.new(event)

      expect(checker.users).to eq([tenant])
    end

    it 'should not show users that have read the event' do
      residency = create(:residency)
      tenant = residency.user
      tenant2 = create(:user)
      create(:residency,
             property: residency.property,
             unit: residency.unit,
             company: residency.company,
             user: tenant2)

      event = create(:event, unit: residency.unit)
      create(:event_read, event: event, reader: tenant2)

      checker = described_class.new(event)

      expect(checker.users).to eq([tenant])
    end
  end

  describe '#managers' do
    it 'should find managers if event has a property' do
      residency = create(:residency)
      property_manager = create(:property_manager, company: residency.property.company)
      event = create(:event, property: residency.property)

      checker = described_class.new(event)

      expect(checker.managers).to eq([property_manager])
    end

    it 'should not find managers if event has a event read from manager' do
      residency = create(:residency)
      property_manager = create(:property_manager, company: residency.property.company)
      property_manager2 = create(:property_manager, company: residency.property.company)
      event = create(:event, property: residency.property)
      create(:event_read, event: event, reader: property_manager2)

      checker = described_class.new(event)

      expect(checker.managers).to eq([property_manager])
    end
  end
end

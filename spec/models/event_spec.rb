# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  eventable_type     :string
#  eventable_id       :integer
#  event_type         :string
#  serialized_changes :jsonb
#  object_type        :string
#  serialized_record  :jsonb
#  createable_type    :string
#  createable_id      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'will take a snapshot of the eventable record' do
    property = create(:property)
    event = described_class.create!(eventable: property,
                                    createable: property,
                                    event_type: Event::EVENT_CREATED)

    expect(event.serialized_record).to eq(property.to_json)
  end

  describe "read_by" do
    it 'will return event_read where user is that user' do
      event = create(:event)
      user = create(:user)
      read = create(:event_read, reader: user, event: event)

      expect(event.read_by(user)).to eq([read])
    end
  end

  describe "#has_been_read_by?" do
    it 'will return true if user has read an event' do
      event = create(:event)
      user = create(:user)
      create(:event_read, reader: user, event: event)

      expect(event.has_been_read_by?(user)).to be_truthy
    end
  end

  it 'will record what changed through previous_changes' do
    property = create(:property)
    property.update_attributes!(name: "something else")

    event = described_class.create!(eventable: property,
                                    createable: property,
                                    event_type: Event::EVENT_EDITED)

    expect(event.serialized_changes).to be
  end
end

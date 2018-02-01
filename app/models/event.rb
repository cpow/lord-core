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

class Event < ApplicationRecord
  ACCEPTED_INVITE = 'Accepted Invite'.freeze
  EVENT_EDITED = 'Edited'.freeze
  EVENT_CREATED = 'Created'.freeze
  EVENT_DESTROYED = 'Destroyed'.freeze

  EVENT_TYPES = [
    ACCEPTED_INVITE,
    EVENT_EDITED,
    EVENT_CREATED,
    EVENT_DESTROYED
  ]

  belongs_to :eventable, polymorphic: true
  belongs_to :createable, polymorphic: true

  validates :event_type, inclusion: { in: Event::EVENT_TYPES }
  validates :eventable, presence: true

  before_create :take_snapshot_of_record, :record_what_changed

  def take_snapshot_of_record
    self.serialized_record = eventable.to_json
  end

  def record_what_changed
    self.serialized_changes = eventable.previous_changes
  end
end

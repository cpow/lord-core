# == Schema Information
#
# Table name: events
#
#  id                 :bigint(8)        not null, primary key
#  eventable_type     :string
#  eventable_id       :bigint(8)
#  event_type         :string
#  serialized_changes :jsonb
#  object_type        :string
#  serialized_record  :jsonb
#  createable_type    :string
#  createable_id      :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  property_id        :bigint(8)
#  read               :boolean          default(FALSE)
#  unit_id            :bigint(8)
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
  ].freeze

  belongs_to :eventable, polymorphic: true
  belongs_to :createable, polymorphic: true
  belongs_to :property, optional: true
  belongs_to :unit, optional: true

  has_many :event_reads

  validates :event_type, inclusion: { in: Event::EVENT_TYPES }
  validates :eventable, presence: true

  before_create :take_snapshot_of_record, :record_what_changed

  scope :read_by, ->(user) do
    left_outer_joins(:event_reads)
      .where('event_reads.reader_id = ?', user.id)
      .references(:event)
  end

  def take_snapshot_of_record
    self.serialized_record = eventable.to_json
  end

  def has_been_read_by?(user)
    read_by(user).present?
  end

  def read_by(user)
    event_reads.where(reader: user)
  end

  def body
    eventable_type == 'Issue' ? eventable.description : eventable.try(:body)
  end

  def record_what_changed
    self.serialized_changes = eventable.previous_changes
  end
end

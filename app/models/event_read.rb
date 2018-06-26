# == Schema Information
#
# Table name: event_reads
#
#  id          :bigint(8)        not null, primary key
#  reader_type :string
#  reader_id   :bigint(8)
#  event_id    :bigint(8)
#

class EventRead < ApplicationRecord
  belongs_to :event
  belongs_to :reader, polymorphic: true
end

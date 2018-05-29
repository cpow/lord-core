# == Schema Information
#
# Table name: event_reads
#
#  id          :integer          not null, primary key
#  reader_type :string
#  reader_id   :integer
#  event_id    :integer
#

class EventRead < ApplicationRecord
  belongs_to :event
  belongs_to :reader, polymorphic: true
end

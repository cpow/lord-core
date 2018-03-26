class EventRead < ApplicationRecord
  belongs_to :event
  belongs_to :reader, polymorphic: true
end

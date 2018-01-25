class Message < ApplicationRecord
  belongs_to :unit
  belongs_to :messageable, polymorphic: true
end

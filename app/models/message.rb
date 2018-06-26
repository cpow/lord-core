# == Schema Information
#
# Table name: messages
#
#  id               :bigint(8)        not null, primary key
#  unit_id          :bigint(8)
#  messageable_type :string
#  messageable_id   :bigint(8)
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :unit
  belongs_to :messageable, polymorphic: true
  has_many :events, as: :eventable
end

# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  property_id :integer          not null
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Unit < ApplicationRecord
  belongs_to :property

  validates :name, :property_id, presence: true
end

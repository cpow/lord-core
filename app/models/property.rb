# == Schema Information
#
# Table name: properties
#
#  id             :bigint(8)        not null, primary key
#  address_city   :string           not null
#  address_line1  :string           not null
#  address_state  :string           not null
#  address_postal :string           not null
#  name           :string           not null
#  description    :text
#  company_id     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Property < ApplicationRecord
  belongs_to :company
  has_many :units
  has_many :property_images
  has_many :residencies
  has_many :issues
  has_many :users, through: :residencies
  has_many :events, as: :eventable
  has_many :expenses, as: :expenseable

  has_many :notifications, foreign_key: 'property_id', class_name: 'Event'

  def payments
    Payment.where(unit_id: units.pluck(:id))
  end

  def unread_notifications_for(user)
    notifications - notifications.read_by(user)
  end

  def property_managers
    # TODO: assign property managers to a property. don't use everyone from
    # company
    company.property_managers
  end

  validates :address_line1,
    :address_postal,
    :address_city,
    :address_state,
    presence: true
end

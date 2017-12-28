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

  has_many :lease_payments
  has_many :payments
  has_many :leases
  has_many :residencies
  has_many :users, through: :residencies

  validates :name, :property_id, presence: true

  def current_lease
    # NOTE: This needs to be refactored with active status and whatnot. like
    # lease payments
    leases.last || NullLease.new
  end

  def current_lease_payment
    lease_payments.active.last || NullLeasePayment.new
  end
end

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

  validates :name, :property_id, presence: true

  def current_lease_payment
    lease_payments.active.last || NullLeasePayment.new
  end
end

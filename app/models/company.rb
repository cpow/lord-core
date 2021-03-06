# == Schema Information
#
# Table name: companies
#
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  account_type        :string
#  stripe_account_guid :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  bank_account_name   :string
#  bank_account_last4  :string
#  stripe_problem      :boolean          default(FALSE)
#

class Company < ApplicationRecord
  has_many :property_managers
  has_many :properties
  has_many :line_items
  has_many :units, through: :properties
  has_many :issues, through: :properties
  has_many :expenses
  has_many :residencies, through: :properties
  validates :name, presence: true
  has_many :events, as: :eventable

  def has_banking_information?
    bank_account_name.present? && bank_account_last4.present?
  end
end

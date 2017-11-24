# == Schema Information
#
# Table name: companies
#
#  id                  :integer          not null, primary key
#  name                :string
#  account_type        :string
#  stripe_account_guid :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Company < ApplicationRecord
  has_many :property_managers
  has_many :properties
  validates :name, presence: true
end

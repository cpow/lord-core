# == Schema Information
#
# Table name: residencies
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  property_id :integer
#  company_id  :integer
#  unit_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Residency < ApplicationRecord
  attr_accessor :user_email

  belongs_to :property
  belongs_to :user
  belongs_to :unit
  belongs_to :company

  attribute :user_email, :string
end

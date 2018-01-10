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
#  active      :boolean
#

class Residency < ApplicationRecord
  EXISTS = 'exists'.freeze
  ERROR = 'error'.freeze
  SUCCESS = 'success'.freeze

  scope :active, -> { where(active: true) }

  attr_accessor :user_email

  belongs_to :property
  belongs_to :user
  belongs_to :unit
  belongs_to :company

  attribute :user_email, :string
end

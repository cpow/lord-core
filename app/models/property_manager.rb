# == Schema Information
#
# Table name: property_managers
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  company_id             :integer
#  admin                  :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  active                 :boolean
#  invite_token           :string
#  invited_by_id          :integer
#  invite_date            :date
#

class PropertyManager < ApplicationRecord
 # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
      :validatable

  has_one :notification_subscription, dependent: :destroy
  belongs_to :company, optional: true
  has_many :properties, through: :company
  has_many :messages, as: :messageable, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy

  include Avatarable
  include PlaceholderPasswordable

  has_one_attached :avatar

  scope :inactive, -> { where(activated: false) }

  def has_company?
    company.present?
  end

  def dummy_company_name
    "#{email} company"
  end

  def is_company_admin?
    has_company? && admin
  end

  def make_admin_with_company(company)
    update_attributes!(company: company, admin: true)
  end
end

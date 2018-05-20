# == Schema Information
#
# Table name: property_managers
#
#  id                     :integer          not null, primary key
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
#

class PropertyManager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :notification_subscription, dependent: :destroy
  belongs_to :company, optional: true
  has_many :messages, as: :messageable, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy

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

  def set_placeholder_password
    self.password = unique_password
  end

  def unique_password
    @unique_password ||= SecureRandom.base58(24)
  end
end

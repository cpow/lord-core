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
#  first_name             :string
#  last_name              :string
#  company_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class PropertyManager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company, optional: true

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

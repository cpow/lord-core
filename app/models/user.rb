# == Schema Information
#
# Table name: users
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
#  invite_token           :string
#  invited_by_id          :integer
#  invite_date            :datetime
#  activated              :boolean          default(FALSE)
#  stripe_account_guid    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_secure_token :invite_token

  has_many :residencies
  has_many :units,      through: :residencies
  has_many :properties, through: :residencies
  has_many :companies,  through: :residencies
  has_many :payments

  scope :inactive, -> { where(activated: false) }

  def set_placeholder_password
    self.password = unique_password
  end

  def unique_password
    @unique_password ||= SecureRandom.base58(24)
  end
end

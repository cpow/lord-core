# == Schema Information
#
# Table name: users
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
#  invite_token           :string
#  invited_by_id          :integer
#  invite_date            :datetime
#  activated              :boolean          default(FALSE)
#  stripe_account_guid    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  bank_account_guid      :string
#  bank_account_last4     :string
#  bank_account_name      :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable

  include Avatarable
  include PlaceholderPasswordable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_secure_token :invite_token

  has_one :notification_subscription
  has_many :residencies
  has_many :manual_payments
  has_many :units,      through: :residencies
  has_many :properties, through: :residencies
  has_many :companies,  through: :residencies
  has_many :messages, as: :messageable
  has_many :events, as: :eventable

  has_many :payments

  has_one_attached :avatar

  scope :inactive, -> { where(activated: false) }

  def status
    activated ? 'active' : 'pending'
  end

  def issues
    Issue.where(reporter: self)
  end

  def needs_to_sign_up_for_plaid?
    !stripe_account_guid.present?
  end

  def current_unit
    units.last.present? ? units.last : NullUnit.new
  end

  def current_lease
    current_unit.current_lease
  end

  def has_lease?
   !current_lease.is_a?(NullLease)
  end

  def current_lease_payment
    current_unit.current_lease_payment
  end

  def current_human_amount_owed
    current_lease_payment.human_amount_due
  end
end

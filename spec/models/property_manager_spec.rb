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

require 'rails_helper'

RSpec.describe PropertyManager, type: :model do
  describe '#has_company?' do
    it 'returns true if a company exists' do
      pm = build_stubbed(:property_manager, :with_company)
      expect(pm.has_company?).to be_truthy
    end
  end

  describe '#is_company_admin?' do
    it 'returns true if manager has company AND is admin' do
      pm = build_stubbed(:property_manager, :with_company, admin: true)
      expect(pm.is_company_admin?).to be_truthy
    end

    it 'returns false if user doesn\'t have company' do
      pm = build_stubbed(:property_manager, admin: true)
      expect(pm.is_company_admin?).to be_falsey
    end

    it 'returns false if user doesn\'t have amdin priveleges' do
      pm = build_stubbed(:property_manager, :with_company, admin: false)
      expect(pm.is_company_admin?).to be_falsey
    end
  end

  describe '#make_admin_with_company' do
    it 'will associate manager with company, and make admin, etc...' do
      pm = create(:property_manager)
      company = create(:company)

      pm.make_admin_with_company(company)
      pm.reload

      expect(pm.company).to eq(company)
      expect(company.property_managers).to include(pm)
      expect(pm.is_company_admin?).to be_truthy
    end
  end
end

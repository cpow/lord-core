# == Schema Information
#
# Table name: stripe_accounts
#
#  id                    :bigint(8)        not null, primary key
#  first_name            :string
#  last_name             :string
#  account_type          :string
#  dob_month             :string
#  dob_day               :string
#  dob_year              :string
#  address_city          :string
#  address_state         :string
#  address_line1         :string
#  address_postal        :string
#  tos                   :boolean          default(FALSE)
#  ssn_last_4            :string
#  business_name         :string
#  business_tax_id       :string
#  business_id_number    :string
#  verification_document :string
#  stripe_account_guid   :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe StripeAccount, type: :model do
end

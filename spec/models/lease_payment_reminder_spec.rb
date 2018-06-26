# == Schema Information
#
# Table name: lease_payment_reminders
#
#  id               :bigint(8)        not null, primary key
#  email_text       :text
#  reminder_type    :string           not null
#  lease_payment_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe LeasePaymentReminder, type: :model do
end

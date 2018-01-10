# == Schema Information
#
# Table name: charge_events
#
#  id               :integer          not null, primary key
#  stripe_charge_id :string
#  event_type       :string
#  stripe_event_id  :string
#  failure_code     :string
#  failure_message  :string
#  payment_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe ChargeEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

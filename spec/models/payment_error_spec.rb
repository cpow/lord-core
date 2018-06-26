# == Schema Information
#
# Table name: payment_errors
#
#  id            :bigint(8)        not null, primary key
#  error_message :text
#  amount        :integer
#  property_id   :bigint(8)
#  unit_id       :bigint(8)
#  lease_id      :bigint(8)
#  user_id       :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe PaymentError, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

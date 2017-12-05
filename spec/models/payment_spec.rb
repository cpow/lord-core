# == Schema Information
#
# Table name: payments
#
#  id              :integer          not null, primary key
#  amount          :integer
#  amount_refunded :integer
#  unit_id         :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Payment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

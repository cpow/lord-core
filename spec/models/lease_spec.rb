# == Schema Information
#
# Table name: leases
#
#  id                      :integer          not null, primary key
#  start_date              :datetime
#  end_date                :datetime
#  payment_first_date      :datetime
#  payment_amount          :integer
#  payment_days_until_late :integer
#  payment_reminder_days   :integer
#  unit_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  payment_id              :integer
#

require 'rails_helper'

RSpec.describe Lease, type: :model do
end

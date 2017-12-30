# == Schema Information
#
# Table name: lease_payments
#
#  id            :integer          not null, primary key
#  company_id    :integer          not null
#  unit_id       :integer          not null
#  lease_id      :integer          not null
#  due_date      :datetime
#  reminder_date :datetime
#  past_due_date :datetime
#  active        :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe LeasePayment, type: :model do
end

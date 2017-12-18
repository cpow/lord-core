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
  describe 'next_lease_payment_from_date' do
    it 'will get the next lease payment from the passed in date' do
      Timecop.freeze(Time.zone.now.beginning_of_day)
      lease = create(:lease)
      first = create(:lease_payment,
                     lease: lease,
                     due_date: Time.now.beginning_of_day
                    )
      second = create(:lease_payment,
                      lease: lease,
                      due_date: Time.now.beginning_of_day + 2.days
                     )

      time = Time.now.beginning_of_day

      current_payment = lease.next_lease_payment_from_date(time)

      expect(current_payment).to eq(second)

      previous_payment = lease.next_lease_payment_from_date(time - 1.day)

      expect(previous_payment).to eq(first)
    end
  end
end

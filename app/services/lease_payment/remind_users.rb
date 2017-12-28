class LeasePayment::RemindUsers
  def self.rent_is_due
    @lease_payments = LeasePaymentQuery
                      .new
                      .search
                      .for_currently_due
                      .for_no_reminders

    @lease_payments.each do |lease_payment|
      send_reminder_email(lease_payment)
      LeasePaymentReminder.create!(lease_payment: lease_payment)
    end
  end

  def self.send_reminder_email(lease_payment)
    LeasePaymentMailer
      .remind_tenants_lease_is_due(lease_payment)
      .deliver_later
  end
end

class LeasePayment::RemindUsers
  def self.rent_is_due
    reminder_type = LeasePaymentReminder::REMINDER_TYPE_DUE_NOW

    @lease_payments = LeasePaymentQuery
                      .new
                      .search
                      .for_currently_due
                      .for_no_reminders_of_type(reminder_type)

    @lease_payments.each do |lease_payment|
      send_rent_due_email(lease_payment)
      LeasePaymentReminder.create!(
        lease_payment: lease_payment,
        reminder_type: reminder_type
      )
    end
  end

  def self.rent_is_coming_up
    reminder_type = LeasePaymentReminder::REMINDER_TYPE_DUE_SOON

    @lease_payments = LeasePaymentQuery
                      .new
                      .search
                      .for_payments_due_soon
                      .for_no_reminders_of_type(reminder_type)

    @lease_payments.each do |lease_payment|
      send_rent_reminder_email(lease_payment)
      LeasePaymentReminder.create!(
        lease_payment: lease_payment,
        reminder_type: reminder_type
      )
    end
  end

  def self.rent_is_late
    reminder_type = LeasePaymentReminder::REMINDER_TYPE_DUE_LATE

    @lease_payments = LeasePaymentQuery
                      .new
                      .search
                      .for_currently_late
                      .for_no_reminders_of_type(reminder_type)

    @lease_payments.each do |lease_payment|
      send_rent_late_email(lease_payment)
      LeasePaymentReminder.create!(
        lease_payment: lease_payment,
        reminder_type: reminder_type
      )
    end
  end

  def self.send_rent_due_email(lease_payment)
    user_emails = lease_payment.users.pluck(:email)
    user_emails.each do |email|
      LeasePaymentMailer
        .remind_tenants_lease_is_due(lease_payment, email)
        .deliver_later
    end
  end

  def self.send_rent_reminder_email(lease_payment)
    user_emails = lease_payment.users.pluck(:email)
    user_emails.each do |email|
      LeasePaymentMailer
        .remind_tenants_lease_is_due_soon(lease_payment, email)
        .deliver_later
    end
  end

  def self.send_rent_late_email(lease_payment)
    user_emails = lease_payment.users.pluck(:email)
    user_emails.each do |email|
      LeasePaymentMailer
        .remind_tenants_lease_is_late(lease_payment, email)
        .deliver_later
    end
  end
end

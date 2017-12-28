class LeasePaymentMailer < ApplicationMailer
  def remind_tenants_lease_is_due(lease_payment)
    @lease_payment = lease_payment
    subject = "Reminder, rent is due on #{@lease_payment.formatted_due_date}"
    user_emails = @lease_payment.users.pluck(:email)

    mail(to: user_emails.shift, bcc: user_emails, subject: subject)
  end
end

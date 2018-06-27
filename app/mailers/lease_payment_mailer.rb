class LeasePaymentMailer < ApplicationMailer
  def remind_tenants_lease_is_due(lease_payment, email)
    @lease_payment = lease_payment
    subject = "Reminder, rent is due today"

    mail(to: email, subject: subject)
  end

  def remind_tenants_lease_is_due_soon(lease_payment, email)
    @lease_payment = lease_payment
    subject = "Reminder, rent is due soon, on #{@lease_payment.formatted_due_date}"

    mail(to: email, subject: subject)
  end

  def remind_tenants_lease_is_late(lease_payment, email)
    @lease_payment = lease_payment
    subject = "Rent is currently late, due on #{@lease_payment.formatted_due_date}"

    mail(to: email, subject: subject)
  end
end

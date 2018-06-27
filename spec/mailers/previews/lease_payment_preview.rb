# Preview all emails at http://localhost:3000/rails/mailers/lease_payment
class LeasePaymentPreview < ActionMailer::Preview
  def remind_tenants_lease_is_due
    LeasePaymentMailer.remind_tenants_lease_is_due(
      LeasePayment.first, User.first.email
    )
  end

  def remind_tenants_lease_is_due_soon
    LeasePaymentMailer.remind_tenants_lease_is_due_soon(
      LeasePayment.first, User.first.email
    )
  end

  def remind_tenants_lease_is_late
    LeasePaymentMailer.remind_tenants_lease_is_late(
      LeasePayment.first, User.first.email
    )
  end
end

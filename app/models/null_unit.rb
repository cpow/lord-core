class NullUnit
  def current_lease_payment
    @null_lease_payment ||= NullLeasePayment.new
  end
end

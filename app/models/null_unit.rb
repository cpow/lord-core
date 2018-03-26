class NullUnit
  def id
    0
  end

  def current_lease_payment
    @null_lease_payment ||= NullLeasePayment.new
  end

  def current_lease
    @null_lease ||= NullLease.new
  end
end

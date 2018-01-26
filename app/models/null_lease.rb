class NullLease
  def start_date
    Time.zone.now
  end

  def end_date
    Time.zone.now
  end

  def total_payments
    0
  end

  def total_paid
    0
  end

  def lease_payments
    []
  end
end

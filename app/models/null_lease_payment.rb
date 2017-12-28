class NullLeasePayment
  def human_amount_due
    0
  end

  def id
    nil
  end

  def due_date
    Time.zone.now
  end

  def payment_late?
    false
  end

  def payment_due?
    false
  end

  def payment_within_reminder_period?
    false
  end

  def due_in_days
    0
  end
end

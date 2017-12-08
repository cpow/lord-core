class LeasePayment::CreateFromLease
  attr_accessor :lease

  def initialize(lease:)
    @lease = lease
  end

  def create_payments
    total_months = number_of_months_in_lease

    (0..total_months).each do |num_of_months|
      payment_date = @lease.payment_first_date + num_of_months.months

      LeasePayment.create!(
        unit: @lease.unit,
        lease: @lease,
        due_date: payment_date,
        past_due_date: payment_date + @lease.payment_days_until_late.days,
        reminder_date: payment_date - @lease.payment_reminder_days.days,
        active: num_of_months.eql?(0)
      )
    end
  end

  private

  def calculated_date(date)
    date.year * 12 + date.month
  end

  def number_of_months_in_lease
    calculated_date(@lease.end_date) - calculated_date(@lease.start_date)
  end
end

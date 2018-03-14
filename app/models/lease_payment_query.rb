class LeasePaymentQuery
  attr_accessor :relation

  def initialize(relation = LeasePayment.active)
    @relation = relation.extending(Scopes)
  end

  def search
    @relation
  end

  module Scopes
    def for_currently_due
      where('due_date = ?', Time.zone.now.beginning_of_day)
    end

    def for_currently_late
      where('past_due_date = ?', Time.zone.now.beginning_of_day)
    end

    def for_payments_due_soon
      where('reminder_date = ?', Time.zone.now.beginning_of_day)
    end

    def for_no_reminders
      includes(:lease_payment_reminders)
        .having('lease_payment_reminders.count <= ?', 0)
        .references(:lease_payment_reminders)
        .group('lease_payments.id')
        .group('lease_payment_reminders.id')
    end

    def for_no_reminders_of_type(reminder_type)
      with_reminders_but_not_of_type(reminder_type) + for_no_reminders
    end

    def with_reminders_but_not_of_type(reminder_type)
      joins(:lease_payment_reminders)
        .where('lease_payment_reminders.reminder_type != ?', reminder_type)
    end

    def active_lease_payments
      active
    end
  end
end

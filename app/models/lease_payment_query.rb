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

    def for_no_reminders
      includes(:lease_payment_reminders)
        .having('lease_payment_reminders.count <= ?', 0)
        .references(:lease_payment_reminders)
        .group('lease_payments.id')
        .group('lease_payment_reminders.id')
    end

    def active_lease_payments
      active
    end
  end
end

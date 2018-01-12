module LeasePaymentsHelper
  def payment_badge(payment)
    case payment.latest_event_type
    when ChargeEvent::PENDING_TYPE
      'badge-warning'
    when ChargeEvent::FAILURE_TYPE
      'badge-danger'
    when ChargeEvent::SUCCEEDED_TYPE
      'badge-success'
    when ChargeEvent::CREATED_TYPE
      'badge-info'
    else
      'badge-secondary'
    end
  end
end

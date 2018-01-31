module LeasesHelper
  def badge_for_lease_payment_status(lease_payment)
    if lease_payment.paid_in_full?
      content_tag(:span, 'success', class: 'badge badge-primary')
    elsif lease_payment.payment_late?
      content_tag(:span, 'late', class: 'badge badge-danger')
    elsif lease_payment.payment_within_reminder_period?
      content_tag(:span, 'due soon', class: 'badge badge-warning')
    elsif lease_payment.active
      content_tag(:span, 'active', class: 'badge badge-info')
    else
      content_tag(:span, 'N/A', class: 'badge badge-secondary')
    end
  end
end

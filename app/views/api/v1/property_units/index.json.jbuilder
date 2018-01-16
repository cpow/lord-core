json.units @units do |unit|
  json.current_lease unit.current_lease
  json.current_lease_payment unit.current_lease_payment
  json.url property_unit_path(@property, unit)
  json.badge do
    lease_payment = unit.current_lease_payment

    if lease_payment.active
      json.class 'info'
      json.value 'active'
    elsif lease_payment.paid_in_full?
      json.class 'success'
      json.value 'paid'
    else
      json.class 'secondary'
      json.value 'N/A'
    end
  end
  json.number_of_tenants unit.users.count
  json.extract! unit, :id, :property_id, :description, :name
end


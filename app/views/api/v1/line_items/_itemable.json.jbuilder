json.(itemable, :created_at, :amount, :human_amount, :description)

if itemable.is_a?(ManualPayment) || itemable.is_a?(Payment)
  json.url property_unit_lease_payment_url(itemable.unit.property, itemable.unit, itemable.lease_payment)
elsif itemable.is_a?(Expense)
  json.url expense_url(itemable)
end

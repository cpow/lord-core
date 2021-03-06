json.(
  event,
  :id,
  :property_id,
  :eventable,
  :eventable_type,
  :event_type,
  :serialized_changes,
  :serialized_record,
  :createable,
  :event_reads,
  :createable_type
)

json.read (event.has_been_read_by?(current_user))
json.lease_id (event.eventable.try(:lease_payment)&.lease_id)
json.lease_payment_id (event.eventable.try(:lease_payment)&.id)

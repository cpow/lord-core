json.events @events do |event|
  json.extract!(
    event,
    :id,
    :eventable,
    :eventable_type,
    :event_type,
    :serialized_changes,
    :serialized_record,
    :createable,
    :createable_type
    )
end


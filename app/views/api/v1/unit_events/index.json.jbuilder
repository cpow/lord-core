json.pagination do
  json.total_pages @events.total_pages
  json.current_page @events.current_page
  json.next_page @events.next_page
  json.prev_page @events.prev_page
end

json.events @events do |event|
  json.partial! 'api/v1/events/event', event: event, current_user: @current_user
end


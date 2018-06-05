json.pagination do
  json.total_pages @line_items.total_pages
  json.current_page @line_items.current_page
  json.next_page @line_items.next_page
  json.prev_page @line_items.prev_page
end

json.line_items @line_items do |line_item|
  json.partial! 'api/v1/line_items/line_item', line_item: line_item
end

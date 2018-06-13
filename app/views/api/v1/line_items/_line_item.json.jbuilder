json.(
  line_item,
  :id,
  :itemable_type,
  :created_at,
  :itemable_id,
  :company_id
)

json.itemable do
  json.partial! 'api/v1/line_items/itemable', itemable: line_item.itemable, as: :itemable
end

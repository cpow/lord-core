json.residencies @residencies do |residency|
  json.user residency.user
  json.unit residency.unit
  json.extract! residency, :id, :user_id
end

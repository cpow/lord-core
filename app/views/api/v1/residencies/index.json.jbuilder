json.residencies @residencies do |residency|
  json.user residency.user
  json.unit residency.unit

  json.badge do
    status = residency.user.status
    if status == 'active'
      json.class 'success'
      json.value 'activated'
    else
      json.class 'warning'
      json.value 'pending'
    end
  end

  json.extract! residency, :id, :user_id, :property_id
end


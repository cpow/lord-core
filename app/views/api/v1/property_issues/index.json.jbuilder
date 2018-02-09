json.issues @issues do |issue|
  json.issue_comments issue.issue_comments
  json.unit issue.unit

  if issue.issue_images.present?
    json.media do
      json.url issue.issue_images.first.image.url(:thumb)
      json.filename issue.issue_images.first.image_file_name
    end
  end

  json.reporter issue.reporter

  json.badge do
    case issue.status
    when Issue::CREATED
      json.class 'info'
      json.value 'created'
    when Issue::ACK
      json.class 'warning'
      json.value 'acknowledged'
    when Issue::IN_PROGRESS
      json.class 'danger'
      json.value 'in progress'
    when Issue::COMPLETED
      json.class 'success'
      json.value 'completed'
    end
  end

  json.extract! issue, :id, :category, :status, :property_id
end


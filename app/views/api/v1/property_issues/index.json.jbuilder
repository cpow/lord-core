json.pagination do
  json.total_pages @issues.total_pages
  json.current_page @issues.current_page
  json.next_page @issues.next_page
  json.prev_page @issues.prev_page
end

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
      json.class 'primary'
      json.value 'created'
    when Issue::ACK
      json.class 'warning'
      json.value 'acknowledged'
    when Issue::IN_PROGRESS
      json.class 'info'
      json.value 'in progress'
    when Issue::COMPLETED
      json.class 'success'
      json.value 'completed'
    end
  end

  json.extract! issue, :id, :category, :status, :property_id, :created_at
end


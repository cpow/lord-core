module Properties::IssuesHelper
  def issue_status_badge(issue)
    case issue.status
    when Issue::CREATED
      'badge badge-primary'
    when Issue::ACK
      'badge badge-warning'
    when Issue::IN_PROGRESS
      'badge badge-info'
    when Issue::COMPLETED
      'badge badge-success'
    end
  end
end

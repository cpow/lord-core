json.issue_comments @issue_comments do |issue_comment|
  json.partial! 'api/v1/issue_comments/issue_comment', issue_comment: issue_comment
end

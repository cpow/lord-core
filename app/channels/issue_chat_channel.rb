class IssueChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from channel_name
  end

  def receive(data)
    issue_comment = create_issue_comment(data)
    ActionCable.server.broadcast(channel_name, json_for_comment(issue_comment))
  end

  def create_issue_comment(data)
    issue_comment = IssueComment.create!(
      issue_id: params[:issueId],
      body: data['body'],
      commentable_id: data['commentableId'],
      commentable_type: data['commentableType']
    )

    property = issue_comment.issue.property
    unit = issue_comment.issue.unit

    event = Event.create!(
      eventable: issue_comment,
      createable: issue_comment.commentable,
      event_type: Event::EVENT_CREATED,
      property: property,
      unit: unit
    )

    event.event_reads.create!(reader: current_user)

    issue_comment
  end

  private

  def json_for_comment(issue_comment)
    Api::V1::IssueCommentsController.render(
      'show',
      assigns: { issue_comment: issue_comment })
  end

  def channel_name
    @channel_name ||= "issue_channel_#{params[:issueId]}"
  end
end

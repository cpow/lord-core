import React from 'react';
import ReactDOM from 'react-dom';
import IssueChat from 'components/issues/IssueChat';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('issueId');
  const issueId = JSON.parse(node.getAttribute('data-issue-id'));

  const commentableNode = document.getElementById('commentable');

  const commentableId = JSON.parse(commentableNode.getAttribute('data-id'));
  const commentableType = commentableNode.getAttribute('data-type');

  ReactDOM.render(
    <IssueChat
      issueId={issueId}
      commentableType={commentableType}
      commentableId={commentableId}
    />,

    document.getElementById('issue_chat'),
  );
});

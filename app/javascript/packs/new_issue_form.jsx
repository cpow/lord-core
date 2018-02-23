import React from 'react';
import ReactDOM from 'react-dom';
import NewIssueForm from 'components/issues/NewIssueForm';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <NewIssueForm />,
    document.getElementById('new_issue'),
  );
});

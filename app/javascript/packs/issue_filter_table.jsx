import React from 'react';
import ReactDOM from 'react-dom';
import createBrowserHistory from 'history/createBrowserHistory';
import IssueFilterTable from 'components/issues/IssueFilterTable';

const history = createBrowserHistory();

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  let propertyId;

  if (node !== null) {
    propertyId = JSON.parse(node.getAttribute('data-property-id'));
  }

  ReactDOM.render(
    <IssueFilterTable propertyId={propertyId} />
    document.getElementById('issue_table'),
  );
});

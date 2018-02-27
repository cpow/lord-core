import React from 'react';
import ReactDOM from 'react-dom';
import { Router } from 'react-router-dom';
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
    <Router history={history}>
      <IssueFilterTable propertyId={propertyId} />
    </Router>,
    document.getElementById('issue_table'),
  );
});

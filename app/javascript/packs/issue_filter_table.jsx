import React from 'react';
import ReactDOM from 'react-dom';
import IssueFilterTable from 'components/issues/IssueFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  let propertyId;

  if (node !== null) {
    propertyId = JSON.parse(node.getAttribute('data-property-id'));
  }

  ReactDOM.render(
    <IssueFilterTable propertyId={propertyId} />,
    document.getElementById('issue_table'),
  );
});

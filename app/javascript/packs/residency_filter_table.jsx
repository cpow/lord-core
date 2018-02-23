import React from 'react';
import ReactDOM from 'react-dom';
import ResidencyFilterTable from 'components/residencies/ResidencyFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  let propertyId;

  if (node !== null) {
    propertyId = JSON.parse(node.getAttribute('data-property-id'));
  }

  ReactDOM.render(
    <ResidencyFilterTable propertyId={propertyId} />,
    document.getElementById('residency_table'),
  );
});

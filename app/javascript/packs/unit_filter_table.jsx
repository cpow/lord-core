import React from 'react';
import ReactDOM from 'react-dom';
import UnitFilterTable from 'components/units/UnitFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  let propertyId;

  if (node !== null) {
    propertyId = JSON.parse(node.getAttribute('data-property-id'));
  }

  ReactDOM.render(
    <UnitFilterTable propertyId={propertyId} />,
    document.getElementById('unit_table'),
  );
});


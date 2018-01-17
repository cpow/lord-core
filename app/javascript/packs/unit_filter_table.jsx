import React from 'react';
import ReactDOM from 'react-dom';
import UnitFilterTable from 'components/units/UnitFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  const propertyId = JSON.parse(node.getAttribute('data-property-id'));

  ReactDOM.render(
    <UnitFilterTable propertyId={propertyId}/>,
    document.body.appendChild(document.createElement('div')),
  )
})


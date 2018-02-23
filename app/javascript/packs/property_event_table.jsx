import React from 'react';
import ReactDOM from 'react-dom';
import PropertyEventFilterTable from 'components/events/PropertyEventFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  const propertyId = JSON.parse(node.getAttribute('data-property-id'));

  ReactDOM.render(
    <PropertyEventFilterTable propertyId={propertyId} />,
    document.getElementById('property_events'),
  );
});

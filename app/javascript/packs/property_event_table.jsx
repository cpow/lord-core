import React from 'react';
import ReactDOM from 'react-dom';
import PropertyEventFilterTable from 'components/events/PropertyEventFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  const readerNode = document.getElementById('reader');

  const propertyId = JSON.parse(node.getAttribute('data-property-id'));
  const readerId = JSON.parse(readerNode.getAttribute('data-reader-id'));
  const readerType = readerNode.getAttribute('data-reader-type');

  ReactDOM.render(
    <PropertyEventFilterTable
      propertyId={propertyId}
      readerId={readerId}
      readerType={readerType}
    />,

    document.getElementById('property_events'),
  );
});

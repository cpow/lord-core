import React from 'react';
import ReactDOM from 'react-dom';
import PropertyEventFilterTable from 'components/events/PropertyEventFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('unitId');
  const readerNode = document.getElementById('reader');

  const unitId = JSON.parse(node.getAttribute('data-unit-id'));
  const readerId = JSON.parse(readerNode.getAttribute('data-reader-id'));
  const readerType = readerNode.getAttribute('data-reader-type');

  ReactDOM.render(
    <PropertyEventFilterTable
      unitId={unitId}
      readerId={readerId}
      readerType={readerType}
    />,

    document.getElementById('property_events'),
  );
});


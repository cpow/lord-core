import React from 'react';
import ReactDOM from 'react-dom';
import ResidencyFilterTable from 'components/residencies/ResidencyFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  const propertyId = JSON.parse(node.getAttribute('data-property-id'));
  console.log(App);

  ReactDOM.render(
    <ResidencyFilterTable propertyId={propertyId}/>,
    document.body.appendChild(document.createElement('div')),
  )
})

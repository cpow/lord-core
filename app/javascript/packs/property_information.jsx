import React from 'react';
import ReactDOM from 'react-dom';
import PropertyInformation from 'components/properties/PropertyInformation';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('propertyId');
  const propertyId = JSON.parse(node.getAttribute('data-property-id'));

  ReactDOM.render(
    <PropertyInformation propertyId={propertyId}/>,
    document.getElementById('property_information')
  )
})


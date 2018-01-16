import React from 'react';
import ReactDOM from 'react-dom';
import UnitFilterTable from 'components/UnitFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <UnitFilterTable/>,
    document.body.appendChild(document.createElement('div')),
  )
})


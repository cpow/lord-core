import React from 'react';
import ReactDOM from 'react-dom';
import LineItemFilterTable from 'components/line_items/LineItemFilterTable';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <LineItemFilterTable />,
    document.getElementById('line_item_filter_table'),
  );
});


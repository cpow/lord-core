import React from 'react';
import PropTypes from 'prop-types';

const FuzzySearchFilter = ({ id, label, filter }) => (
  <div className="col-lg-4 col-sm-12">
    <label htmlFor={id}>
      {label}
      <input id={id} className="form-control" onChange={filter} />
    </label>
  </div>
);

FuzzySearchFilter.propTypes = {
  id: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  filter: PropTypes.func.isRequired,
};

export default FuzzySearchFilter;

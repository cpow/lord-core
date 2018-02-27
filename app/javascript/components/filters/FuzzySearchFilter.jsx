import React from 'react';
import PropTypes from 'prop-types';

const FuzzySearchFilter = ({ id, label, filter, value }) => (
  <div className="col-lg-4 col-sm-12">
    <label htmlFor={id}>
      {label}
    </label>
    <input id={id} className="form-control" onChange={filter} value={value} />
  </div>
);

FuzzySearchFilter.propTypes = {
  id: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  value: PropTypes.string,
  filter: PropTypes.func.isRequired,
};

export default FuzzySearchFilter;

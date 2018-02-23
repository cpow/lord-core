import React from 'react';
import PropTypes from 'prop-types';

const DropDownFilter = ({
  id, label, options, filter,
}) => (
  <div className="col-lg-4 col-sm-12">
    <label htmlFor={id}>
      {label}

      <select id={id} className="form-control" onChange={filter}>
        {options.map(option => (
          <option key={option.label} value={option.label}>{option.value}</option>
        ))}
      </select>
    </label>
  </div>
);

DropDownFilter.propTypes = {
  id: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  options: PropTypes.arrayOf.isRequired,
  filter: PropTypes.func.isRequired,
};

export default DropDownFilter;

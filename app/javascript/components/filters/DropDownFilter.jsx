import React from 'react';
import PropTypes from 'prop-types';

const DropDownFilter = ({
  id, label, options, filter, selected,
}) => (
  <div className="col-lg-4 col-sm-12">
    <label htmlFor={id}>
      {label}
    </label>

    <select id={id} className="form-control" onChange={filter}>
      {options.map(option => (
        <option
          key={option.label}
          value={option.value}
          selected={selected === option.value}
        >
          {option.label}
        </option>
      ))}
    </select>
  </div>
);

DropDownFilter.propTypes = {
  id: PropTypes.string.isRequired,
  selected: PropTypes.string,
  label: PropTypes.string.isRequired,
  options: PropTypes.arrayOf.isRequired,
  filter: PropTypes.func.isRequired,
};

export default DropDownFilter;

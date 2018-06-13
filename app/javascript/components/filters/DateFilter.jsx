import React from 'react';
import PropTypes from 'prop-types';
import Flatpickr from 'react-flatpickr';

const DateFilter = ({
  id, label, filter, value,
}) => (
  <div className="col-lg-4 col-sm-12">
    <div className="form-group">
      <label htmlFor={id}>{label}</label>

      <Flatpickr
        className="form-control"
        id={id}
        onChange={filter}
        value={value}
      />
    </div>
  </div>
);

DateFilter.propTypes = {
  id: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  value: PropTypes.string.isRequired,
  filter: PropTypes.func.isRequired,
};

export default DateFilter;


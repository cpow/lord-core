import React from 'react';
import PropTypes from 'prop-types';

const UnitList = ({ units }) => (
  <div className="table-responsive">
    <table className="table table-striped table-hover">
      <thead className="thead-default">
        <tr>
          <th scope="row">Name</th>
          <th scope="row"># of tenants</th>
          <th scope="row">Status</th>
          <th scope="row">Links</th>
        </tr>
      </thead>

      <tbody>
        {units.map(unit => (
          <tr key={unit.id}>
            <a href={unit.url}>
              <td>{unit.name}</td>
            </a>
            <td>{unit.number_of_tenants}</td>
            <td>
              <span className={`badge badge-${unit.badge.class}`}>
                {unit.badge.value}
              </span>
            </td>
            <td>
              <a href={`${unit.url}/messages`} className="ml-3">
                Chat
              </a>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  </div>
);

UnitList.propTypes = {
  units: PropTypes.arrayOf.isRequired,
};

export default UnitList;

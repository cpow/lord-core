import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class ResidencyTable extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="table-responsive">
        <table className="table table-striped table-hover">
          <thead className="thead-default">
            <tr>
              <th scope="row">Name</th>
              <th scope="row">Email</th>
              <th scope="row">Unit</th>
              <th scope="row">Status</th>
              <th scope="row">Links</th>
            </tr>
          </thead>

          <tbody>
            {this.props.residencies.map(residency => (
              <tr key={residency.id}>
                <td>{residency.user.name}</td>
                <td>{residency.user.email}</td>
                <a href={`/properties/${residency.property_id}/units/${residency.unit.id}`}>
                  <td>{residency.unit.name}</td>
                </a>
                <td>
                  <span className={`badge badge-${residency.badge.class}`}>
                    {residency.badge.value}
                  </span>
                </td>
                <td>
                  <a href={`/properties/${residency.property_id}/residencies/${residency.id}`}>Show</a>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    )
  }
}

ResidencyTable.propTypes = {
  units: PropTypes.array
}

export default ResidencyTable;

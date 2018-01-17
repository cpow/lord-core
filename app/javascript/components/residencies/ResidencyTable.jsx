import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class ResidencyTable extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <table className="table table-striped">
          <thead className="thead-default">
            <tr>
              <th scope="row">Name</th>
              <th scope="row">Email</th>
              <th scope="row">Unit Name</th>
            </tr>
          </thead>

          <tbody>
            {this.props.residencies.map(residency => (
              <tr key={residency.id}>
                <td>{residency.user.name}</td>
                <td>{residency.user.email}</td>
                <td>{residency.unit.name}</td>
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

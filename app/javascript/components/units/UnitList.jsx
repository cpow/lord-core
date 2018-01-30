import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

const DEFAULT_LENGTH = 5;

class UnitList extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <table className="table table-striped table-responsive">
          <thead className="thead-default">
            <tr>
              <th scope="row">Name</th>
              <th scope="row"># of tenants</th>
              <th scope="row">Status</th>
              <th scope="row">Links</th>
            </tr>
          </thead>

          <tbody>
            {this.props.units.map(unit => (
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
    )
  }
}

UnitList.propTypes = {
  units: PropTypes.array
}

export default UnitList;

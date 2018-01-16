import React from 'react';
import PropTypes from 'prop-types';
import ReactTable from 'react-table';
import "react-table/react-table.css";

const { Component } = React;

const DEFAULT_LENGTH = 5;

class UnitList extends Component {
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
              <th scope="row">Description</th>
              <th scope="row"># of tenants</th>
            </tr>
          </thead>

          <tbody>
            {this.props.units.map(unit => (
              <tr key={unit.id}>
                <td>{unit.name}</td>
                <td>{unit.description}</td>
                <td>{unit.number_of_tenants}</td>
                <td>
                  <span className={`badge badge-${unit.badge.class}`}>
                    {unit.badge.value}
                  </span>
                </td>
                <td><a href={unit.url}>Show</a></td>
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

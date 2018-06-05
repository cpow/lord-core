import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class LineItemTable extends Component {
  render() {
    return (
      <div className="table-responsive">
        <table className="table table-striped table-hover">
          <thead className="thead-default">
            <tr>
              <th scope="row">ID</th>
              <th scope="row">Type</th>
              <th scope="row">Amount</th>
            </tr>
          </thead>

          <tbody>

            {this.props.lineItems.map(lineItem => (
              <tr key={lineItem.id}>
                <td>{lineItem.id}</td>
                <td>{lineItem.itemable_type}</td>
                <td>{lineItem.itemable.amount}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }
}

LineItemTable.propTypes = {
  lineItems: PropTypes.array.isRequired,
};

export default LineItemTable;

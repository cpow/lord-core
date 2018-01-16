import React from 'react';

const { Component } = React;

class FilterUnits extends Component {
  render() {
    return (
      <div className="row mb-4">
        <div className="col-lg-4 col-sm-12">
          <label for="filterStatus">Payment Status</label>
          <select id="filterStatus" className="form-control" onChange={this.props.filterStatus}>
            <option value="">All</option>
            <option value="active">Active</option>
            <option value="paid">Paid</option>
          </select>
        </div>
      </div>
    )
  }
}

export default FilterUnits;

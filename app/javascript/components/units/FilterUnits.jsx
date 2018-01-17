import React from 'react';

const { Component } = React;

class FilterUnits extends Component {
  render() {
    return (
      <div className="row mb-4">
        <div className="col-lg-4 col-sm-12">
          <label htmlFor="filterStatus">Payment Status</label>
          <select id="filterStatus" className="form-control" onChange={this.props.filterStatus}>
            <option value="">All</option>
            <option value="active">Active</option>
            <option value="paid">Paid</option>
          </select>
        </div>
        <div className="col-lg-4 col-sm-12">
          <label htmlFor="fuzzyFilterName">Search Name</label>
          <input id="fuzzyFilterName" className="form-control" onChange={this.props.fuzzyFilterName} />
        </div>
      </div>
    )
  }
}

export default FilterUnits;

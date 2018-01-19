import React from 'react';

const { Component } = React;

class  ResidencyFilters extends Component {
  render() {
    return (
      <div className="row mb-4">
        <div className="col-lg-4 col-sm-12">
          <label htmlFor="fuzzyFilterName">Search Name</label>
          <input id="fuzzyFilterName"
            className="form-control"
            onChange={this.props.fuzzyFilterName} />
        </div>
        <div className="col-lg-4 col-sm-12">
          <label htmlFor="fuzzyFilterEmail">Search Email</label>
          <input id="fuzzyFilterEmail"
            className="form-control"
            onChange={this.props.fuzzyFilterEmail} />
        </div>
      </div>
    )
  }
}

export default ResidencyFilters;

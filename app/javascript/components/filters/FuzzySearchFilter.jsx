import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class FuzzySearchFilter extends Component {
  render() {
    return (
      <div className="col-lg-4 col-sm-12">
        <label htmlFor={this.props.id}>{this.props.label}</label>
        <input id={this.props.id} className="form-control" onChange={this.props.filter} />
      </div>
    )
  }
}

FuzzySearchFilter.propTypes = {
  id: PropTypes.string,
  label: PropTypes.string,
  filter: PropTypes.func
}

export default FuzzySearchFilter;


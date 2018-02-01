import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class DropDownFilter extends Component {
  render() {
    return (
      <div className="col-lg-4 col-sm-12">
        <label htmlFor={this.props.id}>{this.props.label}</label>
        <select id={this.props.id} className="form-control" onChange={this.props.filter}>
          {this.props.options.map(option => (
            <option key={option.label} value={option.label}>{option.value}</option>
          ))}
        </select>
      </div>
    )
  }
}

DropDownFilter.propTypes = {
  id: PropTypes.string,
  label: PropTypes.string,
  options: PropTypes.array,
  filter: PropTypes.func
}

export default DropDownFilter;


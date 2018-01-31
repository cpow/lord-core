import React from 'react';

const { Component } = React;

class Loader extends Component {
  render() {
    return (
      <div className="text-center mt-4">
        <i className="fa fa-spinner fa-spin fa-4x"></i>
      </div>
    )
  }
}

export default Loader;

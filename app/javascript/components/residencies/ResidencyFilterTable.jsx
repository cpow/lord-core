import React from 'react';
import PropTypes from 'prop-types';
import getProperty from 'util/dynamic-property';
import axios from 'axios';
import ResidencyTable from 'components/residencies/ResidencyTable';
import ResidencyFilters from 'components/residencies/ResidencyFilters';

const { Component } = React;

class ResidencyFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { residencies: [], filteredResidencies: [] };
    this.fuzzyFilterName = this.fuzzyFilterName.bind(this);
    this.fuzzyFilterEmail = this.fuzzyFilterEmail.bind(this);
  }

  componentDidMount() {
    let propertyId = this.props.propertyId;

    axios.get(`/api/v1/properties/${propertyId}/residencies`).then(resp => {
      let residencies = resp.data.residencies;
      this.setState({ residencies, filteredResidencies: residencies });
    }).catch(error => {
      console.log(error)
    });
  }

  filterBy(property, e) {
    let str = e.target.value;
    let pattern = str.replace(/[^a-zA-Z0-9_-]/, '').split('').join('.*');
    let matcher = new RegExp(pattern, 'i');

    if ( str === '' ) {
      this.setState({ filteredResidencies: this.state.residencies });
    } else {
      let filtered = this.state.residencies.filter(residency => {
        return matcher.test(getProperty(residency, property));
      })

      this.setState({ filteredResidencies: filtered});
    }
  }

  fuzzyFilterName(e) {
    return this.filterBy('user.name', e);
  }

  fuzzyFilterEmail(e) {
    return this.filterBy('user.email', e);
  }

  render() {
    let output = null;

    if ( this.state.residencies.length > 0 ) {
      output =
        <div>
          <ResidencyFilters
            fuzzyFilterName={this.fuzzyFilterName}
            fuzzyFilterEmail={this.fuzzyFilterEmail} />
          <ResidencyTable residencies={this.state.filteredResidencies} />
        </div>;
    } else {
      output =
        <div className="alert alert-warning">
          You don't have any residents associated to this property.
        </div>
    }
    return (
      <div className="container">
        <div className="card">
          <div className="card-body">
            {output}
          </div>
        </div>
      </div>
    )
  }
};

ResidencyFilterTable.propTypes = {
  propertyId: PropTypes.number
}

export default ResidencyFilterTable;


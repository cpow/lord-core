import React from 'react';
import PropTypes from 'prop-types';
import getProperty from 'util/dynamic-property';
import axios from 'axios';
import ResidencyTable from 'components/residencies/ResidencyTable';
import FuzzySearchFilter from 'components/filters/FuzzySearchFilter';
import Loader from 'components/Loader';

const { Component } = React;

class ResidencyFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { residencies: [], filteredResidencies: [], loading: true };
    this.fuzzyFilterName = this.fuzzyFilterName.bind(this);
    this.fuzzyFilterUnitName = this.fuzzyFilterUnitName.bind(this);
    this.fuzzyFilterEmail = this.fuzzyFilterEmail.bind(this);
  }

  componentDidMount() {
    let propertyId = this.props.propertyId;
    let url = 'api/v1/residencies';

    if ( propertyId !== undefined ) {
      url = `/api/v1/properties/${propertyId}/residencies`
    }

    axios.get(url).then(resp => {
      let residencies = resp.data.residencies;
      this.setState({
        residencies,
        filteredResidencies: residencies,
        loading: false
      });
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

  fuzzyFilterUnitName(e) {
    return this.filterBy('unit.name', e);
  }

  fuzzyFilterEmail(e) {
    return this.filterBy('user.email', e);
  }

  render() {
    let output = null;

    if ( this.state.residencies.length > 0 ) {
      output =
        <div>
          <div className="row mb-4">
            <FuzzySearchFilter
              id="fuzzyFilterName"
              label="Search Name"
              filter={this.fuzzyFilterName} />
            <FuzzySearchFilter
              id="fuzzyFilterEmail"
              label="Search Email"
              filter={this.fuzzyFilterEmail} />
            <FuzzySearchFilter
              id="fuzzyFilterUnit"
              label="Search Unit"
              filter={this.fuzzyFilterUnitName} />
          </div>
          <ResidencyTable residencies={this.state.filteredResidencies} />
        </div>;
    } else if (this.state.loading === true) {
      output = <Loader />
    } else {
      output =
        <div className="alert alert-warning text-center no-resident-warning">
          You don't have any residents associated to this property.
        </div>
    }
    return (
      <div>
        {output}
      </div>
    )
  }
};

ResidencyFilterTable.propTypes = {
  propertyId: PropTypes.number
}

export default ResidencyFilterTable;


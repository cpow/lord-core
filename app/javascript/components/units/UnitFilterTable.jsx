import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import UnitList from 'components/units/UnitList';
import Loader from 'components/Loader';
import FuzzySearchFilter from 'components/filters/FuzzySearchFilter';
import DropDownFilter from 'components/filters/DropDownFilter';

const { Component } = React;

const statusOptions = [
  {label: '', value: 'All'},
  {label: 'active', value: 'Active'},
  {label: 'paid', value: 'Paid'}
]

class UnitFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { units: [], filteredUnits: [], loading: true };
    this.filterStatus = this.filterStatus.bind(this);
    this.fuzzyFilterName = this.fuzzyFilterName.bind(this);
  }

  componentDidMount() {
    let propertyId = this.props.propertyId;
    let url = 'api/v1/units';

    if ( propertyId !== undefined ) {
      url = `/api/v1/properties/${propertyId}/units`
    }

    axios.get(url).then(resp => {
      let units = resp.data.units;
      this.setState({
        units,
        filteredUnits: resp.data.units,
        loading: false
      });
    }).catch(error => {
      console.log(error)
    });
  }

  filterStatus(e) {
    let val = e.target.value;
    if ( val === '' ) {
      this.setState({ filteredUnits: this.state.units });
    } else {
      this.setState({ filteredUnits: this.state.units.filter(unit => unit.badge.value == val )});
    }
  }

  fuzzyFilterName(e) {
    let str = e.target.value;
    let pattern = str.replace(/[^a-zA-Z0-9_-]/, '').split('').join('.*');
    let matcher = new RegExp(pattern, 'i');

    if ( str === '' ) {
      this.setState({ filteredUnits: this.state.units });
    } else {
      this.setState({ filteredUnits: this.state.units.filter(unit => matcher.test(unit.name))});
    }
  }

  render() {
    let output = null;

    if ( this.state.units.length > 0 ) {
      output =
        <div>
          <div className="row mb-4">
            <FuzzySearchFilter
              id="filterName"
              label="search name"
              filter={this.fuzzyFilterName} />
            <DropDownFilter
              id="filterStatus"
              label="Payment Status"
              options={statusOptions}
              filter={this.filterStatus} />
          </div>
          <UnitList units={this.state.filteredUnits} />
        </div>
    } else if ( this.state.loading === true ) {
      output = <Loader />
    } else {
      output =
        <div className="alert alert-warning">
          You don't have any units associated to this property.
        </div>
    }
    return (
      <div>
        {output}
      </div>
    )
  }
}

UnitFilterTable.propTypes = {
  propertyId: PropTypes.number
}

export default UnitFilterTable;

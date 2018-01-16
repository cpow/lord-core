import React from 'react';
import axios from 'axios';
import UnitList from 'components/UnitList';
import FilterUnits from 'components/FilterUnits';

const { Component } = React;

class UnitFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { units: [], filteredUnits: [] };
    this.filterStatus = this.filterStatus.bind(this);
  }

  componentDidMount() {
    axios.get('/api/v1/properties/1/units').then(resp => {
      let units = resp.data.units;
      this.setState({ units, filteredUnits: resp.data.units });
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

  render() {
    return (
      <div className="container">
        <div className="card">
          <div className="card-body">
            <FilterUnits filterStatus={this.filterStatus} />
            <UnitList units={this.state.filteredUnits} />
          </div>
        </div>
      </div>
    )
  }
}

export default UnitFilterTable;

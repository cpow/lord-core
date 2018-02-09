import React from 'react';
import PropTypes from 'prop-types';
import FuzzySearchFilter from 'components/filters/FuzzySearchFilter';
import DropDownFilter from 'components/filters/DropDownFilter';
import getProperty from 'util/dynamic-property';
import axios from 'axios';
import IssueTable from 'components/issues/IssueTable';

const { Component } = React;

const categoryOptions = [
  {label: '', value: 'All'},
  {label: 'Electrical', value: 'Electrical'},
  {label: 'Water Damage', value: 'Water Damage'},
  {label: 'Plumbing', value: 'Plumbing'},
  {label: 'Exterior', value: 'Exterior'},
  {label: 'Property / Landscaping', value: 'Property / Landscaping'}
]

class IssueFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { issues: [], filteredIssues: [] };

    this.fuzzyFilterUnitName = this.fuzzyFilterUnitName.bind(this);
    this.filterCategory = this.filterCategory.bind(this);
  }

  filterBy(property, e) {
    let str = e.target.value;
    let pattern = str.replace(/[^a-zA-Z0-9_-]/, '').split('').join('.*');
    let matcher = new RegExp(pattern, 'i');

    if ( str === '' ) {
      this.setState({ filteredIssues: this.state.issues });
    } else {
      let filtered = this.state.issues.filter(issue => {
        return matcher.test(getProperty(issue, property));
      })

      this.setState({ filteredIssues: filtered});
    }
  }

  fuzzyFilterUnitName(e) {
    return this.filterBy('unit.name', e);
  }

  filterCategory(e) {
    let val = e.target.value;
    if ( val === '' ) {
      this.setState({ filteredIssues: this.state.issues });
    } else {
      this.setState({ filteredIssues: this.state.issues.filter(issue => issue.category == val )});
    }
  }

  componentDidMount() {
    let propertyId = this.props.propertyId;

    axios.get(`/api/v1/properties/${propertyId}/issues`).then(resp => {
      let issues = resp.data.issues;
      this.setState({ issues, filteredIssues: issues });
    }).catch(error => {
      console.log(error)
    });
  }

  render() {
    return (
      <div>
        <div class="row mb-4">
          <FuzzySearchFilter
            id="filterUnit"
            label="Search Unit Name"
            filter={this.fuzzyFilterUnitName} />
          <DropDownFilter
            id="filterStatus"
            label="Payment Status"
            options={categoryOptions}
            filter={this.filterCategory} />
        </div>
        <IssueTable issues={this.state.filteredIssues} />
      </div>
    )
  }
}

export default IssueFilterTable;


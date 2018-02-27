import React from 'react';
import queryString from 'query-string';
import PropTypes from 'prop-types';
import FuzzySearchFilter from 'components/filters/FuzzySearchFilter';
import DropDownFilter from 'components/filters/DropDownFilter';
import FetchTable from 'components/issues/FetchTable';

const { Component } = React;

const categoryOptions = [
  { label: '', value: 'All' },
  { label: 'Electrical', value: 'Electrical' },
  { label: 'Water Damage', value: 'Water Damage' },
  { label: 'Plumbing', value: 'Plumbing' },
  { label: 'Exterior', value: 'Exterior' },
  { label: 'Property / Landscaping', value: 'Property / Landscaping' },
];

const statusOptions = [
  { label: '', value: 'All' },
  { label: 'in progress', value: 'in progress' },
  { label: 'acknowledged', value: 'acknowledged' },
  { label: 'completed', value: 'completed' },
  { label: 'created', value: 'created' },
];

const defaultQueryParams = {
  page: 1,
  unitSearch: '',
  status: '',
  category: '',
};

class IssueFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = defaultQueryParams;

    this.fuzzyFilterUnitName = this.fuzzyFilterUnitName.bind(this);
    this.filterCategory = this.filterCategory.bind(this);
    this.filterStatus = this.filterStatus.bind(this);
    this.resetParams = this.resetParams.bind(this);
    this.nextPage = this.nextPage.bind(this);
    this.prevPage = this.prevPage.bind(this);
  }

  componentWillMount() {
    const currentQuery = queryString.parse(window.location.search);
    if (Object.keys(currentQuery).length !== 0) {
      const {
        page, category, status, unitSearch,
      } = currentQuery;
      this.setState({
        page, category, status, unitSearch,
      });
    }
  }

  filterCategory(e) {
    const val = e.target.value;
    this.setState({ category: val });
  }

  filterStatus(e) {
    const val = e.target.value;
    this.setState({ status: val });
  }

  fuzzyFilterUnitName(e) {
    const str = e.target.value;
    this.setState({ unitSearch: str });
  }

  resetParams() {
    this.setState(defaultQueryParams);
  }

  nextPage() {
    let { page } = this.state;
    page = parseInt(page, 10);
    page += 1;
    this.setState({ page });
  }

  prevPage() {
    let { page } = this.state;
    page = parseInt(page, 10);
    page -= 1;
    this.setState({ page });
  }

  render() {
    const {
      unitSearch, category, status, page,
    } = this.state;
    const { propertyId } = this.props;

    return (
      <div>
        <div className="row mb-2">
          <FuzzySearchFilter
            id="filterUnit"
            label="Search Unit Name"
            filter={this.fuzzyFilterUnitName}
            value={this.state.unitSearch}
          />
          <DropDownFilter
            id="filterStatus"
            label="Status"
            options={statusOptions}
            filter={this.filterStatus}
            selected={status}
          />
          <DropDownFilter
            id="filterCategory"
            label="Category"
            options={categoryOptions}
            filter={this.filterCategory}
            selected={category}
          />
        </div>
        <div className="row mb-4">
          <div className="col text-center">
            <button
              onClick={this.resetParams}
              className="btn btn-primary"
            >
              Reset All
            </button>
          </div>
        </div>
        <FetchTable
          unitSearch={unitSearch}
          page={parseInt(page, 10)}
          category={category}
          propertyId={propertyId}
          nextPage={this.nextPage}
          prevPage={this.prevPage}
          status={status}
        />
      </div>
    );
  }
}

IssueFilterTable.propTypes = {
  propertyId: PropTypes.number.isRequired,
};

export default IssueFilterTable;

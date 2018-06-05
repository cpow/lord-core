import React from 'react';
import queryString from 'query-string';
import LineItemFetchTable from 'components/line_items/LineItemFetchTable';
import DropDownFilter from 'components/filters/DropDownFilter';

const { Component } = React;

const defaultQueryParams = {
  page: 1,
};

const typeOptions = [
  { label: 'Expenses', value: 'Expense' },
  { label: 'Manual Payment', value: 'ManualPayment' },
  { label: 'Online Payment', value: 'Payment' },
];

class LineItemFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = defaultQueryParams;

    this.filterType = this.filterType.bind(this);
    this.nextPage = this.nextPage.bind(this);
    this.prevPage = this.prevPage.bind(this);
    this.resetParams = this.resetParams.bind(this);
  }

  componentWillMount() {
    const currentQuery = queryString.parse(window.location.search);
    if (Object.keys(currentQuery).length !== 0) {
      const { page } = currentQuery;
      this.setState({ page });
    }
  }

  resetParams() {
    this.setState(defaultQueryParams);
  }

  filterType(e) {
    const val = e.target.value;
    this.setState({ itemableType: val });
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
    const { page, itemableType } = this.state;

    return (
      <div>
        <div className="row mb-2">
          <DropDownFilter
            id="filterType"
            label="Income or Expense"
            options={typeOptions}
            filter={this.filterType}
            selected={itemableType}
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
        <LineItemFetchTable
          page={parseInt(page, 10)}
          itemableType={this.state.itemableType}
          nextPage={this.nextPage}
          prevPage={this.prevPage}
        />
      </div>
    );
  }
}

export default LineItemFilterTable;

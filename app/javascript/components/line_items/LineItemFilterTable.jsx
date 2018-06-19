import React from 'react';
import queryString from 'query-string';
import LineItemFetchTable from 'components/line_items/LineItemFetchTable';
import DropDownFilter from 'components/filters/DropDownFilter';
import DateFilter from 'components/filters/DateFilter';
import moment from 'moment';

const { Component } = React;

const defaultQueryParams = {
  page: 1,
  itemableType: '',
  startDate: '',
  endDate: '',
};

const typeOptions = [
  { label: 'All', value: 'All' },
  { label: 'Expenses', value: 'Expense' },
  { label: 'Manual Payment', value: 'ManualPayment' },
  { label: 'Online Payment', value: 'Payment' },
];

class LineItemFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = defaultQueryParams;

    this.filterType = this.filterType.bind(this);
    this.filterStartDate = this.filterStartDate.bind(this);
    this.filterEndDate = this.filterEndDate.bind(this);
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
    this.setState({ itemableType: val === 'All' ? '' : val });
  }

  filterEndDate(date) {
    const endDate = moment(date[0]).format('YYYY-MM-DD');
    this.setState({ endDate });
  }

  filterStartDate(date) {
    const startDate = moment(date[0]).format('YYYY-MM-DD');
    this.setState({ startDate });
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
          <DateFilter
            filter={this.filterStartDate}
            value={this.state.startDate}
            label="Start Date"
          />
          <DateFilter
            filter={this.filterEndDate}
            value={this.state.endDate}
            label="End Date"
          />
        </div>
        <div className="row mb-2">
          <div className="col text-center">
            <button
              onClick={this.resetParams}
              className="btn btn-primary pr-4"
            >
              Reset All
            </button>
          </div>
        </div>
        <LineItemFetchTable
          page={parseInt(page, 10)}
          itemableType={this.state.itemableType}
          startDate={this.state.startDate}
          endDate={this.state.endDate}
          nextPage={this.nextPage}
          prevPage={this.prevPage}
        />
      </div>
    );
  }
}

export default LineItemFilterTable;

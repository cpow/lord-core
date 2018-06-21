import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import Pagination from 'components/Pagination';
import LineItemTable from 'components/line_items/LineItemTable';
import Loader from 'components/Loader';

const { Component } = React;

const api = axios.create({
  headers: { Pragma: 'no-cache' },
});

const colorFor = ((itemableType) => {
  return itemableType === 'Expense' ?
    '#d9534f' :
    '#5cb85c';
})

const chartDataReducer = ((accum, currentItem) => {
  const existingItem = accum.find(item =>
    (typeof item === 'object') && (item.x === currentItem.itemable_type));

  if (existingItem) {
    existingItem.y += currentItem.itemable.human_amount;
  } else {
    const obj = {
      x: currentItem.itemable_type,
      y: currentItem.itemable.human_amount,
      color: colorFor(currentItem.itemable_type),
    };
    accum.push(obj);
  }

  return accum;
});

api.defaults.headers.common.Accept = 'application/json';

class LineItemFetchTable extends Component {
  constructor(props) {
    super(props);

    this.state = { lineItems: [], loading: true };
    this.next = this.next.bind(this);
    this.prev = this.prev.bind(this);
    this.onClick = this.onClick.bind(this);
  }

  componentDidMount() {
    this.fetchLineItems();
  }

  componentWillReceiveProps(next) {
    this.fetchLineItems(next);
  }

  onClick(lineItem) {
    window.location = lineItem.itemable.url;
  }

  prev() {
    const { page, prevPage } = this.props;

    if (page > 1) {
      prevPage();
    }
  }

  next() {
    const { page, nextPage } = this.props;
    const { totalPages } = this.state;

    if (page < totalPages) {
      nextPage();
    }
  }

  fetchLineItems(next = null) {
    const newState = this.state;
    newState.loading = true;
    this.setState(newState);
    const currentProps = next !== null ? next : this.props;
    const {
      page, itemableType, startDate, endDate,
    } = currentProps;
    const params = new URLSearchParams();

    params.append('page', page || 1);
    params.append('itemable_type', itemableType || '');
    params.append('start_date', startDate || '');
    params.append('end_date', endDate || '');

    window.history.replaceState({}, '', `?${params.toString()}`);

    const url = `/api/v1/line_items?${params}`;

    api.get(url).then((resp) => {
      const lineItems = resp.data.line_items;
      const totalPages = resp.data.pagination.total_pages;
      const chartData = lineItems.reduce(chartDataReducer, []);
      this.setState({
        lineItems, totalPages, chartData, loading: false,
      });
    }).catch(() => {
      console.log(error);
    });
  }

  render() {
    const { page } = this.props;
    const { totalPages, lineItems, chartData } = this.state;
    let tableOrLoad;

    if (this.state.loading === true) {
      tableOrLoad = (
        <Loader />
      );
    } else {
      tableOrLoad = (
        <div>
          <div className="row mb-2">
            <div className="col text-center">
              <a
                href={`${window.location.origin}${window.location.pathname}.csv${window.location.search}`}
                className="btn btn-secondary"
              >
                Download CSV
              </a>
            </div>
          </div>
          <LineItemTable
            lineItems={lineItems}
            onLineItemClick={this.onClick}
            chartData={chartData}
          />
          <div className="row mt-2">
            <div className="col">
              <Pagination
                page={page}
                totalPages={totalPages}
                nextPage={this.next}
                prevPage={this.prev}
              />
            </div>
          </div>
        </div>
      );
    }

    return (
      <div>
        { tableOrLoad }
      </div>
    );
  }
}

LineItemFetchTable.propTypes = {
  nextPage: PropTypes.func.isRequired,
  prevPage: PropTypes.func.isRequired,
  page: PropTypes.number.isRequired,
};

export default LineItemFetchTable;

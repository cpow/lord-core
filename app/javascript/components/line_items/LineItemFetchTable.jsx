import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import Pagination from 'components/Pagination';
import LineItemTable from 'components/line_items/LineItemTable';

const { Component } = React;

const api = axios.create({
  headers: { Pragma: 'no-cache' },
});

api.defaults.headers.common.Accept = 'application/json';

class LineItemFetchTable extends Component {
  constructor(props) {
    super(props);

    this.state = { lineItems: [] };
    this.next = this.next.bind(this);
    this.prev = this.prev.bind(this);
  }

  componentDidMount() {
    this.fetchLineItems();
  }

  componentWillReceiveProps(next) {
    this.fetchLineItems(next);
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
    this.setState(this.state);
    const currentProps = next !== null ? next : this.props;
    const { page, itemableType } = currentProps;
    const params = new URLSearchParams();

    params.append('page', page || 1);
    params.append('itemable_type', itemableType || '');

    window.history.replaceState({}, '', `?${params.toString()}`);

    const url = `/api/v1/line_items?${params}`;

    api.get(url).then((resp) => {
      const lineItems = resp.data.line_items;
      const totalPages = resp.data.pagination.total_pages;
      this.setState({ lineItems, totalPages });
    }).catch(() => {
      console.log(error);
    });
  }

  render() {
    const { page } = this.props;
    const { totalPages, lineItems } = this.state;

    return (
      <div>
        <div className="row mb-2">
          <div className="col">
            <Pagination
              page={page}
              totalPages={totalPages}
              nextPage={this.next}
              prevPage={this.prev}
            />
          </div>
        </div>
        <LineItemTable lineItems={lineItems} />
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

import React from 'react';
import PropTypes from 'prop-types';
import queryString from 'query-string';
import LineItemFetchTable from 'components/line_items/LineItemFetchTable';

const { Component } = React;

const defaultQueryParams = {
  page: 1,
};

class LineItemFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = defaultQueryParams;

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
    const { page } = this.state;

    return (
      <div>
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
          nextPage={this.nextPage}
          prevPage={this.prevPage}
        />
      </div>
    );
  }
}

export default LineItemFilterTable;

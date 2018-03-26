import React from 'react';
import PropTypes from 'prop-types';
import queryString from 'query-string';
import EventFetchTable from 'components/events/EventFetchTable';

const { Component } = React;

const defaultQueryParams = {
  page: 1,
};

class PropertyEventFilterTable extends Component {
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
        <EventFetchTable
          page={parseInt(page, 10)}
          propertyId={this.props.propertyId}
          readerType={this.props.readerType}
          readerId={this.props.readerId}
          nextPage={this.nextPage}
          prevPage={this.prevPage}
        />
      </div>
    );
  }
}

PropertyEventFilterTable.propTypes = {
  propertyId: PropTypes.number.isRequired,
  readerType: PropTypes.string.isRequired,
  readerId: PropTypes.number.isRequired,
};

export default PropertyEventFilterTable;

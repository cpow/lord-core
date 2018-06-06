import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import IssueTable from 'components/issues/IssueTable';
import Pagination from 'components/Pagination';

const { Component } = React;

class FetchTable extends Component {
  constructor(props) {
    super(props);
    this.state = { issues: [] };
    this.next = this.next.bind(this);
    this.prev = this.prev.bind(this);
  }

  componentDidMount() {
    this.fetchIssues();
  }

  componentWillReceiveProps(next) {
    this.fetchIssues(next);
  }

  fetchIssues(next = null) {
    const currentProps = next !== null ? next : this.props;
    const {
      propertyId, unitSearch, category, status, page,
    } = currentProps;

    const params = new URLSearchParams();
    params.append('page', page || 1);
    params.append('category', category || '');
    params.append('status', status || '');
    params.append('unitSearch', unitSearch || '');

    window.history.replaceState({}, '', `?${params.toString()}`);

    axios.get(`/api/v1/properties/${propertyId}/issues?${params}`).then((resp) => {
      const { issues } = resp.data;
      const totalPages = resp.data.pagination.total_pages;
      this.setState({ issues, totalPages });
    }).catch(() => {
    });
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

  render() {
    const { page } = this.props;
    const { totalPages } = this.state;
    return (
      <div>
        <IssueTable issues={this.state.issues} />
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
}

FetchTable.propTypes = {
  propertyId: PropTypes.number.isRequired,
  unitSearch: PropTypes.string.isRequired,
  category: PropTypes.string.isRequired,
  status: PropTypes.string.isRequired,
  nextPage: PropTypes.func.isRequired,
  prevPage: PropTypes.func.isRequired,
  page: PropTypes.number.isRequired,
};

export default FetchTable;

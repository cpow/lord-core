import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import EventTable from 'components/events/EventTable';
import Pagination from 'components/Pagination';

const { Component } = React;

const api = axios.create({
  headers: { Pragma: 'no-cache' },
});

api.defaults.headers.common.Accept = 'application/json';

class EventFetchTable extends Component {
  constructor(props) {
    super(props);
    this.state = { events: [] };

    this.onMarkEvent = this.onMarkEvent.bind(this);
    this.unreadEvents = this.unreadEvents.bind(this);
    this.next = this.next.bind(this);
    this.prev = this.prev.bind(this);
  }

  componentDidMount() {
    this.fetchEvents();
  }

  componentWillReceiveProps(next) {
    this.fetchEvents(next);
  }

  onMarkEvent(event) {
    const { readerType, readerId } = this.props;
    const data = {
      event_read: {
        reader_type: readerType,
        reader_id: readerId,
      },
    };

    api.post(
      `/api/v1/events/${event.id}/event_reads`,
      data,
    ).then(() => {
      const currentEvents = this.state.events;

      const newEvents = currentEvents.map((e) => {
        if (e.id === event.id) {
          e.read = true;
        }

        return e;
      });

      if (readerType === 'User') {
        switch (event.eventable_type) {
          case 'Message':
            const url = `/units/${event.eventable.unit_id}/messages`;
            window.location.pathname = url;
            break;
          case 'Payment':
            window.location.pathname = `/users/${readerId}/lease_payments/${event.lease_payment_id}`;
            break;
          case 'IssueComment':
            window.location.pathname = `/units/${event.eventable.unit_id}/issues/${event.eventable.issue_id}`;
            break;
          case 'Issue':
            window.location.pathname = `/units/${event.eventable.unit_id}/issues/${event.eventable.issue_id}`;
            break;
          default:
            break;
        }
      } else {
        switch (event.eventable_type) {
          case 'Message':
            const url = `/properties/${event.property_id}/units/${event.eventable.unit_id}/messages`;
            window.location.pathname = url;
            break;
          case 'Payment':
            window.location.pathname = `/properties/${event.property_id}/units/${event.eventable.unit_id}/lease_payments/${event.lease_payment_id}`;
            break;
          case 'IssueComment':
            window.location.pathname = `/properties/${event.property_id}/issues/${event.eventable.issue_id}`;
            break;
          case 'Issue':
            window.location.pathname = `/properties/${event.property_id}/issues/${event.eventable.id}`;
            break;
          default:
            break;
        }
      }

    }).catch((error) => { console.log(error); });
  }

  fetchEvents(next = null) {
    this.setState(this.state);
    const currentProps = next !== null ? next : this.props;
    const {
      propertyId, unitId, page,
    } = currentProps;

    const params = new URLSearchParams();
    params.append('page', page || 1);

    window.history.replaceState({}, '', `?${params.toString()}`);


    // looking for unit events, or property events?
    const url = (unitId === null) ?
      `/api/v1/properties/${propertyId}/events?${params}` :
      `/api/v1/units/${unitId}/events?${params}`;

    api.get(url).then((resp) => {
      const { events } = resp.data;
      const totalPages = resp.data.pagination.total_pages;
      this.setState({ events, totalPages });
    }).catch(() => {
      console.log(error);
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

  unreadEvents() {
    return this.state.events.filter(event => event.read === false);
  }

  render() {
    const { totalPages } = this.state;
    const { page } = this.props;
    const unreadEvents = this.unreadEvents();

    return (
      <div>
        {unreadEvents.length > 0 &&
          <div className="alert alert-danger text-center">
            You have {unreadEvents.length} unread notifications.
          </div>
        }
        <EventTable
          events={this.state.events}
          markEventAsRead={this.onMarkEvent}
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
}

EventFetchTable.propTypes = {
  propertyId: PropTypes.number.isRequired,
  unitId: PropTypes.number.isRequired,
  readerType: PropTypes.string.isRequired,
  readerId: PropTypes.number.isRequired,
  nextPage: PropTypes.func.isRequired,
  prevPage: PropTypes.func.isRequired,
  page: PropTypes.number.isRequired,
};

export default EventFetchTable;

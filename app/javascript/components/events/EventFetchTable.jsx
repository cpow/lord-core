import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import EventTable from 'components/events/EventTable';
import Pagination from 'components/Pagination';

const { Component } = React;

const token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common.Accept = 'application/json';

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
    const data = {
      event: {
        read: true,
      },
    };

    axios.patch(
      `/api/v1/properties/${this.props.propertyId}/events/${event.id}`,
      data,
    ).then(() => {
      const currentEvents = this.state.events;

      const newEvents = currentEvents.map((e) => {
        if (e.id === event.id) {
          e.read = true;
        }

        return e;
      });

      this.setState({ events: newEvents });

      switch (event.eventable_type) {
        case 'Message':
          window.location.pathname = `/properties/${event.property_id}/units/${event.eventable.unit_id}/messages`;
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
    }).catch((error) => { console.log(error); });
  }

  fetchEvents(next = null) {
    const currentProps = next !== null ? next : this.props;
    const {
      propertyId, page,
    } = currentProps;

    const params = new URLSearchParams();
    params.append('page', page || 1);

    window.history.replaceState({}, '', `?${params.toString()}`);

    axios.get(`/api/v1/properties/${propertyId}/events?${params}`).then((resp) => {
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
        <EventTable
          events={this.state.events}
          markEventAsRead={this.onMarkEvent}
        />
      </div>
    );
  }
}

EventFetchTable.propTypes = {
  propertyId: PropTypes.number.isRequired,
  nextPage: PropTypes.func.isRequired,
  prevPage: PropTypes.func.isRequired,
  page: PropTypes.number.isRequired,
};

export default EventFetchTable;

import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import EventTable from 'components/events/EventTable';

const { Component } = React;

const token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common.Accept = 'application/json';

class PropertyEventFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { filteredEvents: [] };
    this.onMarkEvent = this.onMarkEvent.bind(this);
  }

  componentDidMount() {
    const { propertyId } = this.props;

    axios.get(`/api/v1/properties/${propertyId}/events`).then((resp) => {
      const { events } = resp.data;
      this.setState({ filteredEvents: events });
    }).catch(() => {
    });
  }

  onMarkEvent(event) {
    const data = {
      event: {
        read: true,
      },
    };

    axios.patch(`/api/v1/properties/${this.props.propertyId}/events/${event.id}`, data).then(() => {
      const currentEvents = this.state.filteredEvents;

      const newEvents = currentEvents.map((e) => {
        if (e.id === event.id) {
          e.read = true;
        }

        return e;
      });

      this.setState({ filteredEvents: newEvents });

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

  render() {
    return (
      <EventTable
        events={this.state.filteredEvents}
        markEventAsRead={this.onMarkEvent}
      />
    );
  }
}

PropertyEventFilterTable.propTypes = {
  propertyId: PropTypes.number.isRequired,
};

export default PropertyEventFilterTable;

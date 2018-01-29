import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import EventTable from 'components/events/EventTable';

const { Component } = React;

class PropertyEventFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { events: [], filteredEvents: [] };
  }

  componentDidMount() {
    let propertyId = this.props.propertyId;

    axios.get(`/api/v1/properties/${propertyId}/events`).then(resp => {
      let events = resp.data.events;
      this.setState({ events, filteredEvents: events });
    }).catch(error => {
      console.log(error)
    });
  }

  render() {
    return (
      <EventTable events={this.state.filteredEvents} />
    )
  }
}

export default PropertyEventFilterTable;

import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import EventTable from 'components/events/EventTable';

const { Component } = React;

class PropertyEventFilterTable extends Component {
  constructor(props) {
    super(props);
    this.state = { filteredEvents: [] };
  }

  componentDidMount() {
    const { propertyId } = this.props;

    axios.get(`/api/v1/properties/${propertyId}/events`).then((resp) => {
      const { events } = resp.data;
      this.setState({ filteredEvents: events });
    }).catch(() => {
    });
  }

  render() {
    return (
      <EventTable events={this.state.filteredEvents} />
    );
  }
}

PropertyEventFilterTable.propTypes = {
  propertyId: PropTypes.number.isRequired,
};

export default PropertyEventFilterTable;

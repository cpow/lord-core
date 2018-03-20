import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class EventTable extends Component {
  static notificationLink(event) {
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
  }

  static bodyFor(event) {
    if (event.eventable_type === 'Issue') {
      return event.eventable.description;
    }

    return event.eventable.body;
  }

  static badgeFor(event) {
    if (event.eventable_type === 'Issue') {
      return (
        <i className="fa fa-exclamation-triangle pr-3" />
      );
    }

    return (
      <i className="fa fa-comments pr-3" />
    );
  }

  render() {
    return (
      <div className="table-responsive">
        <table className="table table-striped table-hover">
          <thead className="thead-default">
            <tr>
              <th scope="row">Type</th>
              <th scope="row">Description</th>
              <th scope="row">User Name</th>
              <th scope="row">User Type</th>
            </tr>
          </thead>

          <tbody>
            {this.props.events.map(event => (
              <tr key={event.id} onClick={() => EventTable.notificationLink(event)} style={{cursor: 'pointer'}}>
                <td>{EventTable.badgeFor(event)} {`${event.event_type} ${event.eventable_type}`}</td>
                <td>{EventTable.bodyFor(event)}</td>
                <td>{event.createable.name}</td>
                <td>{event.createable_type}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }
}

EventTable.propTypes = {
  events: PropTypes.arrayOf.isRequired,
};

export default EventTable;

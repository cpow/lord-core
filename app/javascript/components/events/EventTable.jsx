import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class EventTable extends Component {
  static bodyFor(event) {
    if (event.eventable_type === 'Issue') {
      return event.eventable.description;
    }

    return event.eventable.body;
  }

  static badgeFor(event) {
    if (event.eventable_type === 'Issue') {
      return (
        <i className="fa fa-exclamation-triangle text-warning pr-3" />
      );
    }

    return (
      <i className="fa fa-comments text-primary pr-3" />
    );
  }

  static classFor(event) {
    return event.read ? '' : 'font-weight-bold';
  }

  constructor(props) {
    super(props);
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
              <tr
                className={EventTable.classFor(event)}
                key={event.id}
                onClick={() => this.props.markEventAsRead(event)}
                style={{ cursor: 'pointer' }}
              >
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
  markEventAsRead: PropTypes.func.isRequired,
};

export default EventTable;

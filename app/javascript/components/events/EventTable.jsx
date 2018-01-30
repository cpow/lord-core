import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class EventTable extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="table-responsive">
        <table className="table table-striped">
          <thead className="thead-default">
            <tr>
              <th scope="row">Type</th>
              <th scope="row">Object ID</th>
              <th scope="row">Action</th>
              <th scope="row">User Name</th>
              <th scope="row">User Type</th>
            </tr>
          </thead>

          <tbody>
            {this.props.events.map(event => (
              <tr key={event.id}>
                <td>{event.eventable_type}</td>
                <td>{event.eventable.id}</td>
                <td>{event.event_type}</td>
                <td>{event.createable.name}</td>
                <td>{event.createable_type}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    )
  }
}

EventTable.propTypes = {
  events: PropTypes.array
}

export default EventTable;


import React from 'react';
import PropTypes from 'prop-types';

const EventTable = ({ events }) => (
  <div className="table-responsive">
    <table className="table table-striped table-hover">
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
        {events.map(event => (
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
);

EventTable.propTypes = {
  events: PropTypes.arrayOf.isRequired,
};

export default EventTable;

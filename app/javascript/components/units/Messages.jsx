import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class Messages extends Component {
  static messageBodyStyle(message) {
    const base = 'card-body';

    if (message.messageable_type === 'PropertyManager') {
      return `${base} bg-primary text-white`;
    }
    return base;
  }

  static rowForMessage(message) {
    const base = 'row col-lg-8 col-sm-12 message';

    if (message.messageable_type === 'PropertyManager') {
      return `${base} float-right`;
    }
    return base;
  }

  render() {
    return (
      <div>
        {this.props.messages.map(message => (
          <div className={this.rowForMessage(message)} key={message.id}>
            <div className="card no-shadow mb-2">
              <div className={this.messageBodyStyle(message)}>
                <small>{message.messageable.email}</small>
                <br />
                {message.body}
              </div>
            </div>
          </div>
        ))}
      </div>
    );
  }
}

Messages.propTypes = {
  messages: PropTypes.arrayOf.isRequired,
};

export default Messages;

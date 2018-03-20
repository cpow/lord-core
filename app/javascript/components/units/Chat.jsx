import React from 'react';
import PropTypes from 'prop-types';
import Messages from 'components/units/Messages';
import ActionCable from 'actioncable';
import axios from 'axios';

const { Component } = React;

class Chat extends Component {
  constructor(props) {
    super(props);
    this.sendData = this.sendData.bind(this);
    this.state = { messages: [] };
  }

  componentDidMount() {
    axios.get(`/api/v1/units/${this.props.unitId}/messages`).then((resp) => {
      const { messages } = resp.data;
      this.setState({ messages });
    }).catch(() => {
    });

    this.cable = ActionCable.createConsumer();

    this.subscription = this.cable.subscriptions.create(
      {
        channel: 'UnitChatChannel',
        unitId: this.props.unitId,
      },

      {
        received: (data) => {
          this.updateMessages(JSON.parse(data));
        },
      },
    );
  }

  componentDidUpdate() {
    const listElements = document.getElementsByClassName('message');
    const lastElement = listElements[listElements.length - 1];
    if (lastElement) {
      lastElement.scrollIntoView(false);
    }
  }

  updateMessages(data) {
    this.state.messages.push(data);
    this.setState({ messages: this.state.messages });
  }

  sendData(e) {
    e.preventDefault();
    const bodyElement = e.target.elements.namedItem('message');
    const body = bodyElement.value;
    bodyElement.value = '';

    const payload = {
      body,
      messageableId: this.props.messageableId,
      messageableType: this.props.messageableType,
      unitId: this.props.unitId,
    };

    this.subscription.send(payload);
  }

  render() {
    return (
      <div className="container">
        <div className="card">
          <div className="card-body">
            <div className="card no-shadow unit-chat rounded mb-4" style={{ height: '500px', overflowY: 'auto' }}>
              <div className="card-body">
                <Messages messages={this.state.messages} />
              </div>
            </div>
            <form onSubmit={this.sendData}>
              <div className="form-group">
                <input type="text" id="message" autocomplete="off" className="dataInput form-control" />
              </div>
              <button type="submit" className="btn btn-primary">New Message</button>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

Chat.propTypes = {
  unitId: PropTypes.number.isRequired,
  messageableId: PropTypes.number.isRequired,
  messageableType: PropTypes.string.isRequired,
};

export default Chat;

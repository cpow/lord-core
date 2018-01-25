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
    this.state = {messages: []}
  }

  sendData(e) {
    e.preventDefault();
    let bodyElement = e.target.elements.namedItem('message');
    let body = bodyElement.value;
    bodyElement.value = '';

    let payload = {
      body,
      messageableId: this.props.messageableId,
      messageableType: this.props.messageableType,
      unitId: this.props.unitId
    }

    this.subscription.send(payload);
  }

  updateMessages(data) {
    this.state.messages.push(data);
    this.setState({messages: this.state.messages});
  }

  componentDidUpdate() {
    let listElements = document.getElementsByClassName('message');
    let lastElement = listElements[listElements.length - 1];
    if (lastElement) {
      lastElement.scrollIntoView(true);
    }
  }

  componentDidMount() {
    axios.get(`/api/v1/units/${this.props.unitId}/messages`).then(resp => {
      let messages = resp.data.messages;
      this.setState({ messages });
    }).catch(error => {
      console.log(error)
    });

    this.cable = ActionCable.createConsumer();

    this.subscription = this.cable.subscriptions.create(
      {
        channel: "UnitChatChannel",
        unitId: this.props.unitId
      },

      {
        received: data => {
          this.updateMessages(JSON.parse(data));
        }
      }
    )
  }

  render() {
    return (
      <div className="container">
        <div className="card">
          <div className="card-body">
            <div className="card rounded mb-4" style={{height: '500px', overflowY: 'auto'}}>
              <div className="card-body">
                <Messages messages={this.state.messages} />
              </div>
            </div>
            <form onSubmit={this.sendData}>
              <div className="form-group">
                <input type="text" id="message" className="dataInput form-control" />
              </div>
              <button type="submit" className="btn btn-primary">New Message</button>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

Chat.propTypes = {
  unitId: PropTypes.number,
  messageableId: PropTypes.number,
  messageableType: PropTypes.string
}

export default Chat;

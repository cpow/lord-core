import React from 'react';
import PropTypes from 'prop-types';
import Comments from 'components/issues/Comments';
import ActionCable from 'actioncable';
import axios from 'axios';

const { Component } = React;

class IssueChat extends Component {
  constructor(props) {
    super(props);
    this.sendData = this.sendData.bind(this);
    this.state = {comments: []}
  }

  sendData(e) {
    e.preventDefault();
    let bodyElement = e.target.elements.namedItem('comment');
    let body = bodyElement.value;
    bodyElement.value = '';

    let payload = {
      body,
      commentableId: this.props.commentableId,
      commentableType: this.props.commentableType,
      issueId: this.props.issueId
    }

    this.subscription.send(payload);
  }

  updateIssueComments(data) {
    this.state.comments.push(data);
    this.setState({ comments: this.state.comments });
  }

  componentDidUpdate() {
    let listElements = document.getElementsByClassName('comment');
    let lastElement = listElements[listElements.length - 1];
    if (lastElement) {
      lastElement.scrollIntoView(true);
    }
  }

  componentDidMount() {
    axios.get(`/api/v1/issues/${this.props.issueId}/issue_comments`).then(resp => {
      let comments = resp.data.issue_comments;
      this.setState({ comments });
    }).catch(error => {
      console.log(error)
    });

    this.cable = ActionCable.createConsumer();

    this.subscription = this.cable.subscriptions.create(
      {
        channel: "IssueChatChannel",
        issueId: this.props.issueId
      },

      {
        received: data => {
          this.updateIssueComments(JSON.parse(data));
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
                <Comments comments={this.state.comments} />
              </div>
            </div>
            <form onSubmit={this.sendData}>
              <div className="form-group">
                <input type="text" id="comment" className="dataInput form-control" />
              </div>
              <button type="submit" className="btn btn-primary">New Comment</button>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

IssueChat.propTypes = {
  issueId: PropTypes.number,
  commentableId: PropTypes.number,
  commentableType: PropTypes.string
}

export default IssueChat;

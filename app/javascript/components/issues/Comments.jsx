import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class Comments extends Component {
  commentBodyStyle(comment) {
    let base = 'card-body';

    if (comment.commentable_type === "PropertyManager") {
      return `${base} bg-primary text-white`
    } else {
      return base
    }
  }

  render() {
    return (
      <div>
        {this.props.comments.map(comment => (
          <div className='comment' key={comment.id}>
            <div className="card no-shadow mb-2">
              <div className={this.commentBodyStyle(comment)}>
                {comment.body}
              </div>
            </div>
          </div>
        ))}
      </div>
    )
  }
}

Comments.propTypes = {
  comments: PropTypes.array
}

export default Comments;
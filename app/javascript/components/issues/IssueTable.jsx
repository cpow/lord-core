import React from 'react';
import PropTypes from 'prop-types';

const { Component } = React;

class IssueTable extends Component {
  constructor(props) {
    super(props);
  }

  issueMediaUrl(issue) {
    if (issue.media) {
      return (
        <img src={issue.media.url} alt={issue.media.filename} />
      )
    }
  }

  render() {
    return (
      <div className="table-responsive">
        <table className="table table-striped">
          <thead className="thead-default">
            <tr>
              <th scope="row">Media</th>
              <th scope="row">Category</th>
              <th scope="row">Status</th>
              <th scope="row">Reporter</th>
              <th scope="row">Unit</th>
            </tr>
          </thead>

          <tbody>

            {this.props.issues.map(issue => (
              <tr key={issue.id}>
                <a href={`/properties/${issue.property_id}/issues/${issue.id}`}>
                  <td>{this.issueMediaUrl(issue)}</td>
                </a>
                <td>
                  <a href={`/properties/${issue.property_id}/issues/${issue.id}`}>
                    {issue.category}
                  </a>
                </td>
                <td>
                  <span className={`badge badge-${issue.badge.class}`}>
                    {issue.badge.value}
                  </span>
                </td>
                <td>{issue.reporter.name}</td>
                <td>{issue.unit.name}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    )
  }
}

IssueTable.propTypes = {
  issues: PropTypes.array
}

export default IssueTable;

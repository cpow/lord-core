import React from 'react';
import IssueDropzone from 'components/issues/IssueDropzone';
import axios from 'axios';

const { Component } = React;

const categories = [
  'Plumbing',
  'Electrical',
  'Water Damage',
  'Physical Damage',
  'Exterior',
  'Property / Landscaping',
];

const token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common.Accept = 'application/json';

class NewIssueForm extends Component {
  static getBase64(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result);
      reader.onerror = error => reject(error);
    });
  }

  constructor(props) {
    super(props);

    this.state = {
      showFileUpload: false, showSuccess: false, files: [], category: categories[0],
    };

    this.handleSubmit = this.handleSubmit.bind(this);
    this.showFileUpload = this.showFileUpload.bind(this);
    this.setCategory = this.setCategory.bind(this);
    this.setFiles = this.setFiles.bind(this);
    this.currentLinkText = this.currentLinkText.bind(this);
    this.section = this.section.bind(this);
    this.setDescription = this.setDescription.bind(this);
  }

  setCategory(e) {
    const category = e.target.value;
    this.setState({ category });
  }

  setFiles(files) {
    this.setState({ files });
  }

  setDescription(e) {
    const description = e.target.value;
    this.setState({ description });
  }

  handleSubmit(e) {
    e.preventDefault();

    NewIssueForm.getBase64(this.state.files[0]).then((fileData) => {
      const data = {
        issue: {
          image: fileData,
          image_file_name: this.state.files[0].name,
          category: this.state.category,
          description: this.state.description,
        },
      };

      axios.post('/api/v1/issues', data).then(() => {
        this.setState({ showSuccess: true });
      });
    });
  }


  showFileUpload(e) {
    e.preventDefault();
    this.setState({ showFileUpload: !this.state.showFileUpload });
  }

  currentLinkText() {
    return this.state.showFileUpload ? 'Previous' : 'Next';
  }

  section() {
    if (this.state.showFileUpload) {
      return (
        <div>
          <div className="form-group">
            <IssueDropzone
              setFiles={this.setFiles}
              selectedFiles={this.state.files}
            />
          </div>
          <div className="form-group">
            <input type="submit" value="Create Issue" className="btn btn-primary btn-block" />
          </div>
        </div>
      );
    }
    return (
      <div>
        <div className="form-group">
          <label htmlFor="issue_category">
              Select Category
            <select
              id="issue_category"
              className="form-control"
              onChange={this.setCategory}
              value={this.state.category}
            >
              {categories.map(option => (
                <option key={option} value={option}>{option}</option>
                ))}
            </select>
          </label>
        </div>
        <div className="form-group">
          <label htmlFor="description">
            Description
            <textarea
              type="text"
              placeholder="Please describe the problem. Leaky pipe, etc..."
              className="form-control"
              id="description"
              value={this.state.description}
              onChange={this.setDescription}
            />
          </label>
        </div>
      </div>
    );
  }

  render() {
    if (this.state.showSuccess) {
      return (
        <div className="card text-center alert alert-success">
          <div className="card-body">
            <h3>Success</h3>
            <p>
              You created a new issue. The property management will be right on this!
            </p>
            <a href="/" className="btn btn-success">Home</a>
          </div>
        </div>
      );
    }
    return (
      <div className="row align-items-start">
        <div className="col-lg-8 col-sm-12">
          <div className="card">
            <div className="card-header">
              <div className="pull-right">
                <button
                  className="next-link"
                  onClick={this.showFileUpload}
                >
                  {this.currentLinkText()}
                </button>
              </div>
            </div>
            <div className="card-body">
              <form onSubmit={this.handleSubmit} className="new-issue__form">
                {this.section()}
              </form>
            </div>
          </div>
        </div>
        <div className="col-lg-4 col-sm-12">
          <h4>Pro tip</h4>
          <small>
              The more information you can tell us about the problem the better.
              Also, please include a picture if you can.
          </small>
          <h4 className="mt-3">Current Info:</h4>
          <small>
            <ul className="unstyled">
              <li>
                <strong>category: </strong>{this.state.category}
              </li>
              <li>
                <strong>description: </strong>{this.state.description}
              </li>
              <li>
                <strong>image:</strong>
                <img
                  src={this.state.files[0] && this.state.files[0].preview}
                  style={{ maxHeight: '100px', width: 'auto' }}
                  alt=""
                />
              </li>
            </ul>
          </small>
        </div>
      </div>
    );
  }
}

export default NewIssueForm;

import React from 'react';
import Dropzone from 'react-dropzone';
import axios from 'axios';

const { Component } = React;

const categories = [
    'Plumbing',
    'Electrical',
    'Water Damage',
    'Physical Damage',
    'Exterior',
    'Property / Landscaping'
];

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'

class Basic extends Component {
  constructor(props) {
    super(props)
    this.state = { files: [] }
  }

  onDrop(files) {
    this.setState({ files });
    this.props.setFiles(files);
  }

  render() {
    let display;

    if (this.props.selectedFiles.length > 0) {
      display = <div className="card col-4">
        <img
          src={this.props.selectedFiles[0].preview}
          className="card-img-top"
          style={{maxHeight: '150px', width: '100%'}}
        />
        <div className="card-body">
          {this.props.selectedFiles[0].name}
        </div>
      </div>;
    } else {
      display = <span></span>;
    }

    return (
      <section>
        <div className="dropzone card alert alert-info">
          <Dropzone
              onDrop={this.onDrop.bind(this)}
              multiple={false} style={{cursor: 'pointer'}}>
            <div className="card-body">
              <div className="row align-items-center">
                <div className="col-lg-2">
                  <i className="fa fa-camera fa-3x"></i>
                </div>
                <div className="col-lg-10">
                  Drop an image here, or select one to upload
                </div>
              </div>
            </div>
          </Dropzone>
        </div>
        <aside>
          <h2>Selected File</h2>
          { display }
        </aside>
      </section>
    );
  }
}

class NewIssueForm extends Component {
  constructor(props) {
    super(props);

    this.state = { showFileUpload: false, showSuccess: false, files: [], category: categories[0] };

    this.handleSubmit = this.handleSubmit.bind(this);
    this.showFileUpload = this.showFileUpload.bind(this);
    this.setCategory = this.setCategory.bind(this);
    this.setFiles = this.setFiles.bind(this);
    this.currentLinkText = this.currentLinkText.bind(this);
    this.section = this.section.bind(this);
    this.setDescription = this.setDescription.bind(this);
  }

  getBase64(file) {
    return new Promise((resolve, reject) => {
      let reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        return resolve(reader.result);
      };
      reader.onerror = function (error) {
        return reject(error);
      };
    });
  }

  handleSubmit(e) {
    e.preventDefault();

    this.getBase64(this.state.files[0]).then(fileData => {
      let data = {
        issue: {
          image: fileData,
          image_file_name: this.state.files[0].name,
          category: this.state.category,
          description: this.state.description
        }
      };

      axios.post('/api/v1/issues', data).then(resp => {
        this.setState({showSuccess: true});
      })
    });
  }

  setCategory(e) {
    let category = e.target.value;
    this.setState({ category });
  }

  setFiles(files) {
    this.setState({files})
  }

  setDescription(e) {
    let description = e.target.value;
    this.setState({ description });
  }

  showFileUpload(e) {
    e.preventDefault();
    this.setState({ showFileUpload: !this.state.showFileUpload })
  }

  currentLinkText() {
    return this.state.showFileUpload ? 'Previous' : 'Next';
  }

  section() {
    if (this.state.showFileUpload) {
      return <div>
        <div className="form-group">
          <Basic
            setFiles={this.setFiles}
            selectedFiles={this.state.files}
          />
        </div>
        <div className="form-group">
          <input type="submit" value="Create Issue" className='btn btn-primary btn-block' />
        </div>
      </div>;
    } else {
      return <div>
          <div className="form-group">
          <label>
            Select Category
          </label>
          <select id="issue_category" className="form-control"
            onChange={this.setCategory}
            value={this.state.category}
          >
            {categories.map(option => (
              <option key={option} value={option}>{option}</option>
            ))}
          </select>
        </div>
        <div className="form-group">
          <label>Description</label>
          <textarea type="text"
            placeholder='Please describe the problem. Leaky pipe, etc...'
            className='form-control'
            value={this.state.description}
            onChange={this.setDescription}
            />
        </div>
      </div>;
    }
  }

  render() {
    if (this.state.showSuccess) {
      return (
        <div className="card text-center alert alert-success">
          <div class="card-body">
            <h3>Success</h3>
            <p>
              You created a new issue. The property management will be right on this!
            </p>
            <a href="/" className="btn btn-success">Home</a>
          </div>
        </div>
      )
    } else {
      return (
        <div className="row align-items-start">
          <div className="col-lg-8 col-sm-12">
            <div className="card">
              <div className="card-header">
                <div className="pull-right">
                  <a href="" onClick={this.showFileUpload} >{this.currentLinkText()}</a>
                </div>
              </div>
              <div className="card-body">
                <form onSubmit={this.handleSubmit}>
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
                <img src={this.state.files[0] && this.state.files[0].preview}
                  style={{maxHeight: '100px', width: 'auto'}}
                />
              </li>
              </ul>
            </small>
          </div>
        </div>
      )
    }
  }
};

export default NewIssueForm;

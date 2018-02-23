import React from 'react';
import PropTypes from 'prop-types';
import Dropzone from 'react-dropzone';

const { Component } = React;

class IssueDropzone extends Component {
  constructor(props) {
    super(props);

    this.onDrop = this.onDrop.bind(this);
  }

  onDrop(files) {
    this.props.setFiles(files);
  }

  render() {
    let display;

    if (this.props.selectedFiles.length > 0) {
      display = (
        <div className="card col-4">
          <img
            src={this.props.selectedFiles[0].preview}
            className="card-img-top"
            style={{ maxHeight: '150px', width: '100%' }}
            alt=""
          />
          <div className="card-body">
            {this.props.selectedFiles[0].name}
          </div>
        </div>
      );
    } else {
      display = <span />;
    }

    return (
      <section>
        <div className="dropzone card alert alert-info">
          <Dropzone
            onDrop={this.onDrop}
            multiple={false}
            style={{ cursor: 'pointer' }}
          >
            <div className="card-body">
              <div className="row align-items-center">
                <div className="col-lg-2">
                  <i className="fa fa-camera fa-3x" />
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

IssueDropzone.propTypes = {
  setFiles: PropTypes.func.isRequired,
  selectedFiles: PropTypes.arrayOf.isRequired,
};

export default IssueDropzone;

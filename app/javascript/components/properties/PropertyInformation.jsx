import React from 'react';
import PropTypes from 'prop-types';
import ResidencyFilterTable from 'components/residencies/ResidencyFilterTable';
import UnitFilterTable from 'components/units/UnitFilterTable';

const { Component } = React;

class PropertyInformation extends Component {
  render() {
    return (
      <div>
        <ul className="nav nav-pills border-bottom" id="" role="tablist">
          <li className="nav-item">
            <a className="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Units</a>
          </li>
          <li className="nav-item">
            <a className="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Residents</a>
          </li>
        </ul>

        <div className="tab-content" id="pills-tabContent" style={{minHeight: '500px'}}>
          <div className="tab-pane fade show active mt-4" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
              <h2 className="text-center mt-4">
                Units
              </h2>
              <p className="text-center mb-4">
                <a href={`/properties/${this.props.propertyId}/units/new`} className='btn btn-primary text-center mb-2'>
                  Create New
                </a>
              </p>
            <UnitFilterTable propertyId={this.props.propertyId}/>
          </div>
          <div className="tab-pane fade mt-4" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
            <h2 className="text-center mt-4">
              Residents
            </h2>
            <p className="text-center mb-4">
              <a href={`/properties/${this.props.propertyId}/residencies/new`} className='btn btn-primary text-center'>
                Create New
              </a>
            </p>
            <ResidencyFilterTable propertyId={this.props.propertyId}/>
          </div>
        </div>
      </div>
    )
  }
}

PropertyInformation.propTypes = {
  propertyId: PropTypes.number
}

export default PropertyInformation;

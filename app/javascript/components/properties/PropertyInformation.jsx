import React from 'react';
import PropTypes from 'prop-types';
import ResidencyFilterTable from 'components/residencies/ResidencyFilterTable';
import UnitFilterTable from 'components/units/UnitFilterTable';
import PropertyEventFilterTable from 'components/events/PropertyEventFilterTable';

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
          <li className="nav-item">
            <a className="nav-link" id="pills-events-tab" data-toggle="pill" href="#pills-events" role="tab" aria-controls="pills-events" aria-selected="false">Events</a>
          </li>
        </ul>

        <div className="tab-content" id="pills-tabContent" style={{minHeight: '500px'}}>
          <div className="tab-pane fade show active mt-4" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
            <div className="row mb-2 border-bottom align-items-end">
              <div className="col-12">
                <h3>
                  Units
                </h3>
              </div>
              <div className="col-12">
                <a href={`/properties/${this.props.propertyId}/units/new`} className='text-uppercase text-success'>
                  Create New
                </a>
              </div>
            </div>
            <UnitFilterTable propertyId={this.props.propertyId}/>
          </div>
          <div className="tab-pane fade mt-4" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
            <div className="row mb-2 border-bottom align-items-end">
              <div className="col-12">
                <h3>
                  Residents
                </h3>
              </div>
              <div className="col-12">
                <a href={`/properties/${this.props.propertyId}/residencies/new`} className='text-uppercase text-success'>
                  Create New
                </a>
              </div>
            </div>
            <ResidencyFilterTable propertyId={this.props.propertyId}/>
          </div>
          <div className="tab-pane fade mt-4" id="pills-events" role="tabpanel" aria-labelledby="pills-events-tab">
            <div className="row mb-2 border-bottom align-items-end">
              <div className="col-12">
                <h3>
                  Events For This Property
                </h3>
              </div>
            </div>
            <PropertyEventFilterTable propertyId={this.props.propertyId}/>
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

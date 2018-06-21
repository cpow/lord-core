import React from 'react';
import PropTypes from 'prop-types';
import Moment from 'react-moment';
import { XYPlot, XAxis, YAxis, VerticalBarSeries, Crosshair } from 'react-vis';

const { Component } = React;

class LineItemTable extends Component {
  static styleFor(lineItem) {
    return lineItem.itemable_type === 'Expense' ?
      'danger' :
      'success';
  }

  constructor(props) {
    super(props);
    this.state = { crosshairValues: [] };
  }

  render() {
    return (
      <div>
        <div className="d-flex justify-content-center">
          {this.props.chartData &&
            <XYPlot
              width={400}
              height={200}
              colorType="literal"
              xType="ordinal"
              onMouseLeave={() => this.setState({crosshairValues: []})}
            >
              <VerticalBarSeries
                data={this.props.chartData}
                onNearestX={(value, {index}) =>
                  this.setState({crosshairValues: [value]})}
              />
              <Crosshair values={this.state.crosshairValues}>
                {this.state.crosshairValues[0] &&
                  <div className={`alert-${LineItemTable.styleFor({itemable_type: this.state.crosshairValues[0].x})}`}>
                    <h4>{this.state.crosshairValues[0].x}s: {this.state.crosshairValues[0].y}</h4>
                  </div>
                }
              </Crosshair>
              <XAxis />
              <YAxis />
            </XYPlot>
          }
        </div>
        <div className="table-responsive">
          <table className="table table-striped table-hover">
            <thead className="thead-default">
              <tr>
                <th scope="row">ID</th>
                <th scope="row">Type</th>
                <th scope="row">Description</th>
                <th scope="row">Created on</th>
                <th scope="row">Amount</th>
              </tr>
            </thead>

            <tbody>

              {this.props.lineItems.map(lineItem => (
                <tr
                  key={lineItem.id}
                  onClick={() => this.props.onLineItemClick(lineItem)}
                  style={{ cursor: 'pointer' }}
                >
                  <td>{lineItem.id}</td>
                  <td>{lineItem.itemable_type}</td>
                  <td>{lineItem.itemable.description}</td>
                  <td>
                    <Moment
                      date={lineItem.created_at}
                      format="MM/DD/YYYY"
                    />
                  </td>
                  <td className={`text-${LineItemTable.styleFor(lineItem)}`}>
                    ${lineItem.itemable.human_amount}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

LineItemTable.propTypes = {
  lineItems: PropTypes.array.isRequired,
  chartData: PropTypes.array.isRequired,
  onLineItemClick: PropTypes.func.isRequired,
};

export default LineItemTable;

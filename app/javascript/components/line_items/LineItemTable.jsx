import React from 'react';
import PropTypes from 'prop-types';
import { XYPlot, XAxis, YAxis, HorizontalGridLines, VerticalBarSeries } from 'react-vis';

const { Component } = React;

class LineItemTable extends Component {
  render() {
    return (
      <div>
        <div className="d-flex justify-content-center">
          {this.props.chartData &&
            <XYPlot width={400} height={200} xType="ordinal">
              <VerticalBarSeries
                data={this.props.chartData}
                animation
              />
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
                  <td>${lineItem.itemable.human_amount}</td>
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

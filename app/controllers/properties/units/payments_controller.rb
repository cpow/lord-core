class Properties::Units::PaymentsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_property
  before_action :set_unit

  def show
    @payment = @unit.payments.find(params[:id])
    @charge_events = @payment.charge_events
  end

  private

  def set_property
    @property ||= Property.find(params[:property_id])
  end

  def set_unit
    @unit ||= Unit.find(params[:unit_id])
  end
end

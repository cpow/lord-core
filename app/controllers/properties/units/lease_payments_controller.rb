class Properties::Units::LeasePaymentsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_property
  before_action :set_unit

  def index
    @lease_payments = @unit.current_lease.lease_payments
  end

  def edit
    @lease_payment = LeasePayment.find(params[:id])
  end

  def show
    @lease_payment = LeasePayment.find(params[:id])
  end

  def update
    @lease_payment = LeasePayment.find(params[:id])
    @lease_payment.assign_attributes(updated_payment_params)

    if @lease_payment.save
      Event.create(eventable: @lease_payment,
                   createable: current_property_manager,
                   event_type: Event::EVENT_EDITED)
      redirect_to [@property, @unit, @lease_payment.lease], notice: 'Lease payment was successfully updated.'
    else
      render :edit
    end
  end

  private

  def updated_payment_params
    original = lease_payment_params.to_hash
    original.update(original) do |key, val|
      key == 'local_amount' ? val.to_i * 100 : val
    end
    original
  end

  def lease_payment_params
    params.require(:lease_payment).permit(:reminder_date,
                                          :active,
                                          :past_due_date,
                                          :local_amount)
  end

  def set_property
    @property ||= Property.find(params[:property_id])
  end

  def set_unit
    @unit ||= Unit.find(params[:unit_id])
  end
end

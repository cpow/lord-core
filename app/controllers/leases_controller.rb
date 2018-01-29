class LeasesController < ApplicationController
  before_action :set_property, :set_unit
  before_action :set_lease, only: [:show, :edit, :update, :destroy]

  # GET /leases
  # GET /leases.json
  def index
    @leases = @unit.leases.all
  end

  # GET /leases/1
  # GET /leases/1.json
  def show
  end

  # GET /leases/new
  def new
    @lease = @unit.leases.new
  end

  # GET /leases/1/edit
  def edit
  end

  # POST /leases
  # POST /leases.json
  def create
    @lease = @unit.leases.new(lease_params)
    change_lease_amount_to_cents
    if @lease.save
      Event.create(eventable: @lease,
                  createable: current_property_manager,
                  event_type: Event::EVENT_CREATED)
      create_lease_payments_for_lease
      redirect_to [@property, @unit, @lease], notice: 'Lease was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /leases/1
  # PATCH/PUT /leases/1.json
  def update
    @lease.assign_attributes(lease_params)
    change_lease_amount_to_cents if @lease.payment_amount_changed?

    if @lease.save
      redirect_to [@property, @unit, @lease], notice: 'Lease was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /leases/1
  # DELETE /leases/1.json
  def destroy
    @lease.destroy
    respond_to do |format|
      format.html { redirect_to leases_url, notice: 'Lease was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def change_lease_amount_to_cents
      @lease.payment_amount = @lease.payment_amount * 100
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_lease
      @lease = @unit.leases.find(params[:id])
    end

    def create_lease_payments_for_lease
      LeasePayment::CreateFromLease.new(lease: @lease).create_payments
    end

    def set_property
      @property ||= Property.find(params[:property_id])
    end

    def set_unit
      @unit ||= Unit.find(params[:unit_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lease_params
      params.require(:lease).permit(:unit_id, :start_date, :end_date, :payment_amount, :payment_first_date, :payment_reminder_days, :payment_days_until_late, :unit_id)
    end
end

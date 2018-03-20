class ManualPaymentsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_lease_payment
  before_action :set_lease
  before_action :set_unit
  before_action :set_property

  def new
    @manual_payment = ManualPayment.new(lease_payment: @lease_payment)
    # build receipts so user can see them on the form
    build_receipts(2)
  end

  def build_receipts(count)
    count.times { @manual_payment.manual_payment_receipts.build }
  end

  def edit
    @manual_payment = ManualPayment.find(params[:id])
    #if there are less than 2 receipts, build enough to allow user to add
    #receipts to manual payment during edit
    build_receipts(2 - @manual_payment.manual_payment_receipts.length)
  end

  def create
    create_params = manual_payment_params.merge(lease_payment: @lease_payment)
    @manual_payment = ManualPayment.new(create_params)

    if @manual_payment.save
      @manual_payment.lease_payment.deal_with_payment
      redirect_to [@property, @unit, @lease_payment],
        notice: 'Created manual payment, thanks!'
    else
      render action: :new, notice: 'There were errors creating this manual payment'
    end
  end

  def update
    @manual_payment = ManualPayment.find(params[:id])

    if @manual_payment.update_attributes(manual_payment_params)
      redirect_to [@property, @unit, @lease_payment],
        notice: 'Created manual payment, thanks!'
    else
      render action: :edit, notice: 'There were errors updating your payment.'
    end
  end

  def destroy
    @manual_payment = ManualPayment.find(params[:id])
    @manual_payment.destroy
    redirect_to [@property, @unit, @lease_payment],
      alert: 'manual payment has been deleted'
  end

  private

  def set_lease
    @lease ||= @lease_payment.lease
  end

  def set_property
    @property ||= @unit.property
  end

  def set_unit
    @unit ||= @lease.unit
  end

  def manual_payment_params
    params.require(:manual_payment).permit(:amount, :description, :user_id, manual_payment_receipts_attributes: [:image])
  end
end

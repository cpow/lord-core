class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_for_stripe_token
  before_action :check_for_company_stripe_token

  def index
    @payments = current_user.payments
  end

  def new
    @payment = current_user.payments.new
    @payment.amount = current_user.current_human_amount_owed
  end

  def create
    payment_stripe_charge = Payment::CreateStripeCharge.new(
      user: current_user,
      company: current_user.residencies.last.company,
      amount: amount
    )

    # NOTE: we need to store whatever comes out of this.
    # Also, need specs around this class
    stripe_charge = payment_stripe_charge.create

    local = current_user.payments.new(
      amount: amount,
      stripe_charge_id: stripe_charge.id,
      unit: current_user.current_unit,
      lease_payment_id: current_user.current_lease_payment.id
    )

    if local.save
      flash[:success] = 'Success! You\'ve submitted your payment'
      if current_user.current_lease.instance_of?(NullLease)
        redirect_to authenticated_user_root_path
      else
        current_user.current_lease_payment.deal_with_payment
        redirect_to user_lease_path(current_user.current_lease)
      end
    else
      flash[:danger] = 'We\'re sorry, something went wrong'
      render :new
    end
  end

  private

  def check_for_stripe_token
    unless current_user.stripe_account_guid.present?
      redirect_to authenticated_user_root_path, notice: 'you must create a payment account first'
    end
  end

  def check_for_company_stripe_token
    unless current_user.companies.last.stripe_account_guid.present?
      redirect_to authenticated_user_root_path, notice: 'The property management company has not yet verified an account to accept payments. sorry :('
    end
  end

  def amount
    @amount ||= (payment_params[:amount].to_i * 100).to_i
  end

  def payment_params
    params.require(:payment).permit(:user_id, :unit_id, :amount)
  end
end

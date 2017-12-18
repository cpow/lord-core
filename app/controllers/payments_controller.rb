class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_for_stripe_token
  before_action :check_for_company_stripe_token

  def index
    @payments = current_user.payments
  end

  def new
    @payment = current_user.payments.new
    @payment.amount = current_user.current_amount_owed
  end

  def create
    # NOTE: refactor this mess
    company_account = current_user.residencies.last.company.stripe_account_guid

    token = Stripe::Token.create({
              customer: current_user.stripe_account_guid,
            }, {stripe_account: company_account})

    data = {
      source: token,
      amount: amount,
      application_fee: (amount / 10),
      currency: 'usd'
    }

    Stripe::Charge
      .create(data, stripe_account: company_account)

    local = current_user.payments.new(
      amount: amount,
      unit: current_user.current_unit,
      lease_payment: current_user.current_lease_payment
    )

    if local.save
      current_user.current_lease_payment.deal_with_payment
      flash[:success] = 'good job pal!'
      redirect_to payments_path
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
    (payment_params[:amount].to_i * 100).to_i
  end

  def payment_params
    params.require(:payment).permit(:user_id, :unit_id, :amount)
  end
end

class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @payments = current_user.payments
  end

  def new
    @payment = current_user.payments.new
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
      unit_id: current_user.units.last.id
    )

    if local.save
      flash[:success] = 'good job pal!'
      redirect_to payments_path
    end
  end

  private

  def transaction_data
  end

  def destination_amount
    (amount * 0.9).to_i
  end

  def amount
    (payment_params[:amount].to_i * 100).to_i
  end

  def payment_params
    params.require(:payment).permit(:user_id, :unit_id, :amount)
  end
end

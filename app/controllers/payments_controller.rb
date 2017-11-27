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
    bank_account = Stripe::Customer.retrieve(current_user.stripe_account_guid).sources.data.first.id

    charge = Stripe::Charge.create({
      source: bank_account,
      amount: amount,
      currency: "usd",
      application_fee: amount/10, # Take a 10% application fee for the platform
      destination: current_user.stripe_account_guid
    })

    local = current_user.payments.new(
      amount: amount,
      unit_id: current_user.unit.last.id
    )

    if local.save
      flash[:success] = 'good job pal!'
      redirect_to payments_path
    end
  end

  private

  def amount
    params[:amount].to_i * 1000
  end

  def payment_params
    params.require(:payment).permit!(:user_id, :unit_id, :amount)
  end
end

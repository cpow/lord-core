class BankAccountsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_manage_company!

  def new
    # Redirect if no stripe account exists yet
    unless current_company.stripe_account_guid
      redirect_to new_stripe_account_path && return
    end

    begin
      # Retrieve the account object for this user
      @account = Stripe::Account.retrieve(current_company.stripe_account_guid)

    # Handle exceptions from Stripe
    rescue Stripe::StripeError => e
      handle_error(e.message, 'new')

    # Handle any other exceptions
    rescue => e
      handle_error(e.message, 'new')
    end
  end

  def create
    # Redirect if no token is POSTed or the user doesn't have a Stripe account
    unless params[:stripeToken] && current_company.stripe_account_guid
      redirect_to new_bank_account_path && return
    end

    begin
      # Retrieve the account object for this user
      account = Stripe::Account.retrieve(current_company.stripe_account_guid)

      # Create the bank account
      token = params[:stripeToken]
      account.external_accounts.create({ external_account: token })

      # Success, send on to the dashboard
      flash[:success] = 'Your bank account has been added!'
      redirect_to authenticated_user_root_path

    # Handle exceptions from Stripe
    rescue Stripe::StripeError => e
      handle_error(e.message, 'new')

    # Handle any other exceptions
    rescue => e
      handle_error(e.message, 'new')
    end
  end
end

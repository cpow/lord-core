class TenantPlaidAccountsController < ApplicationController
  before_action :authenticate_user!

  def new

  end

  def create

    # If a plaid token is submitted, request a bank token
    if params[:public_token] && params[:account_id]
      public_token = params[:public_token]
      account_id = params[:account_id]

      # Get the Stripe bank token from Plaid

      exchange_token_response = PLAID.item.public_token.exchange(public_token)
      access_token = exchange_token_response['access_token']

      stripe_response = PLAID.processor.stripe.bank_account_token.create(access_token, account_id)
      bank_account_token = stripe_response['stripe_bank_account_token']

      # Create Stripe customer with token
      begin
        customer = Stripe::Customer.create(
          source: bank_account_token,
          description: 'Plaid example customer',
          metadata: { 'plaid_account' => account_id }
        )

        current_user.update_attributes!(stripe_account_guid: customer.id)

        # Create session for the bank account
        session[:bank_account] = customer.sources.data.first.id

        # Direct the customer to pay
        flash[:success] = 'Your bank account has been connected.'
        redirect_to new_payment_path
      rescue Stripe::RateLimitError => e
        # Too many requests made to the API too quickly
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        flash[:alert] = e.message
        render 'create'
      end
    else
      flash[:alert] = 'No Plaid token provided'
      render 'create'
    end

  end
end


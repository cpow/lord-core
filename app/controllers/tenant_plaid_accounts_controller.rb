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

        stripe_bank_token = customer.sources.data.last.id
        stripe_bank_name = customer.sources.data.last.bank_name
        stripe_bank_last4 = customer.sources.data.last.last4

        current_user.update_attributes!(
          stripe_account_guid: customer.id,
          bank_account_guid: stripe_bank_token,
          bank_account_name: stripe_bank_name,
          bank_account_last4: stripe_bank_last4
        )

        # Direct the customer to pay
        flash[:success] = 'Your bank account has been connected.'
        redirect_to authenticated_user_root_path
      rescue Stripe::RateLimitError => e
        # Too many requests made to the API too quickly
        flash[:alert] = e.message
        redirect_to authenticated_user_root_path
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
        flash[:alert] = e.message
        redirect_to authenticated_user_root_path
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        flash[:alert] = e.message
        redirect_to authenticated_user_root_path
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        flash[:alert] = e.message
        redirect_to authenticated_user_root_path
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        flash[:alert] = e.message
        redirect_to authenticated_user_root_path
      end
    else
      flash[:alert] = 'No Plaid token provided'
      redirect_to authenticated_user_root_path
    end
  end
end


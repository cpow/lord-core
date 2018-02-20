class PayoutsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_manage_company!
  before_action :set_company

  def show
    # Retrieve the payout from Stripe to get details
    # TODO: Store this stuff locally eventually with webhooks
    if params[:id]
      begin
        if @company.has_banking_information?
          @stripe_account = Stripe::Account.retrieve(@company.stripe_account_guid)

          # Get the payout details
          @payout = Stripe::Payout.retrieve(
            {
              id: params[:id]
            },
            { stripe_account: @company.stripe_account_guid }
          )

          # Get the balance transactions from the payout
          @txns = Stripe::BalanceTransaction.list(
            {
              payout: params[:id],
              expand: ['data.source.source_transfer', 'data.source.charge.source_transfer'],
              limit: 100
            },
            { stripe_account: @company.stripe_account_guid }
          )
        end
      # Handle exceptions from Stripe
      rescue Stripe::StripeError => e
        flash[:error] = e.message
        redirect_to root_path
      rescue => e
        # Something else happened, completely unrelated to Stripe
        flash[:error] = e.message
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, this payout was not found"
      redirect_to root_path
    end
  end

  private

  def set_company
    @company ||= current_property_manager.company
  end
end


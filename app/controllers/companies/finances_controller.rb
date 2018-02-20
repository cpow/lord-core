class Companies::FinancesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_manage_company!
  before_action :set_property_manager
  before_action :set_company

  def show
    begin
      if @company.has_banking_information?
        @account = Stripe::Account.retrieve(stripe_guid)

        # Last 100 payouts from the managed account to their bank account
        @payouts = Stripe::Payout.list(
          {
            limit: 100,
            expand: ['data.destination']
          },
          { stripe_account: stripe_guid }
        )

        balance = Stripe::Balance.retrieve(
          { stripe_account: stripe_guid  }
        )

        @available = balance.available.first.amount
        @pending = balance.pending.first.amount
        @balance_available = @available + @pending
      end

    rescue Stripe::StripeError => e
      flash[:error] = e.message
      redirect_to root_path

    rescue => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end

  private

  def stripe_guid
    @stripe_guid ||= @company.stripe_account_guid
  end

  def set_company
    @company ||= current_property_manager.company
  end

  def set_property_manager
    @property_manager ||= current_property_manager
  end
end

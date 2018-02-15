class Companies::FinancesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_manage_company!
  before_action :set_property_manager
  before_action :set_company

  def show
    if @company.has_banking_information?
      @account = Stripe::Account.retrieve(@company.stripe_account_guid)
      @balance = Stripe::Balance.retrieve(
        { stripe_account: @company.stripe_account_guid  }
      )
    end
  end

  private

  def set_company
    @company ||= current_property_manager.company
  end

  def set_property_manager
    @property_manager ||= current_property_manager
  end
end

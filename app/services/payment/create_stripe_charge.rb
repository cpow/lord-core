# NOTE: needs specs and handling of errors and whatnot
class Payment::CreateStripeCharge
  def initialize(user:, company:, amount:)
    @user = user
    @amount = amount
    @company = company
  end

  def create
    company_account = @company.stripe_account_guid

    token = Stripe::Token.create(
      { customer: @user.stripe_account_guid },
      stripe_account: company_account
    )

    data = {
      source: token,
      amount: @amount,
      # NOTE: need to handle subscriptions at some point for fees.
      # Perhaps each account has an account type, and that type can dictate what
      # your fees are? Maybe its just computed based on the # of units a
      # property has with payments. but then you'd have to account fo that
      # (imagine a company creates 100 blank units to get around the tiers...)
      # food for thought
      application_fee: StripeApplicationFee.for_amount(@amount),
      currency: 'usd'
    }

    Stripe::Charge
      .create(data, stripe_account: company_account)
  end
end

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
      application_fee: (@amount / 10),
      currency: 'usd'
    }

    Stripe::Charge
      .create(data, stripe_account: company_account)
  end
end

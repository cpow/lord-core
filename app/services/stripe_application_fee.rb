class StripeApplicationFee
  FEE_PERCENTAGE = 0.0075

  def self.for_amount(amount)
    (amount.to_f * FEE_PERCENTAGE).to_f
  end
end

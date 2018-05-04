class StripeApplicationFee
  FEE_PERCENTAGE = 0.007

  def self.for_amount(amount)
    (amount * FEE_PERCENTAGE).to_i
  end
end

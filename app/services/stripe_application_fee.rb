class StripeApplicationFee
  FEE_PERCENTAGE = 0.0075

  def self.for_amount(amount)
    (amount * FEE_PERCENTAGE).round.to_i
  end
end

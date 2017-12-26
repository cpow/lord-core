require 'rails_helper'

describe StripeApplicationFee do
  describe '.for_amount' do
    it 'should return a percentage of the original cost' do
      amount = 1000
      result = described_class.for_amount(amount)
      expected = amount * described_class::FEE_PERCENTAGE

      expect(result).to eq(expected)
    end
  end
end

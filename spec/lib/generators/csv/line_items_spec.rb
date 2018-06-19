require 'csv'
require 'rails_helper'

describe Generators::Csv::LineItems do
  it 'should instantiate' do
    expect(described_class.new([])).to be_truthy
  end

  it 'should do something with a CSV' do
    line_item = create(:line_item)

    csv = described_class.new([line_item]).generate
    parsed = CSV.parse(csv)
    expect(parsed.length).to eq(2)
    expect(parsed[1]).to include(line_item.itemable.amount.to_s)
  end
end

require 'rails_helper'

RSpec.describe "leases/index", type: :view do
  before(:each) do
    assign(:leases, [
      Lease.create!(
        :payment_amount => 2,
        :payment_days_until_late => 4,
        :unit_id => 5
      ),
      Lease.create!(
        :payment_amount => 2,
        :payment_days_until_late => 4,
        :unit_id => 5
      )
    ])
  end

  it "renders a list of leases" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end

require 'rails_helper'

RSpec.describe "leases/new", type: :view do
  before(:each) do
    assign(:lease, Lease.new(
      :payment_amount => 1,
      :payment_due_day_of_month => 1,
      :payment_days_until_late => 1,
      :unit_id => 1
    ))
  end

  it "renders new lease form" do
    render

    assert_select "form[action=?][method=?]", leases_path, "post" do

      assert_select "input[name=?]", "lease[payment_amount]"

      assert_select "input[name=?]", "lease[payment_due_day_of_month]"

      assert_select "input[name=?]", "lease[payment_days_until_late]"

      assert_select "input[name=?]", "lease[unit_id]"
    end
  end
end

require 'rails_helper'

RSpec.describe "leases/edit", type: :view do
  before(:each) do
    @lease = assign(:lease, Lease.create!(
      :payment_amount => 1,
      :payment_due_day_of_month => 1,
      :payment_days_until_late => 1,
      :unit_id => 1
    ))
  end

  it "renders the edit lease form" do
    render

    assert_select "form[action=?][method=?]", lease_path(@lease), "post" do

      assert_select "input[name=?]", "lease[payment_amount]"

      assert_select "input[name=?]", "lease[payment_due_day_of_month]"

      assert_select "input[name=?]", "lease[payment_days_until_late]"

      assert_select "input[name=?]", "lease[unit_id]"
    end
  end
end

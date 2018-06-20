require 'rails_helper'

feature 'User checks out their payment information' do
  scenario 'after logging in and clicking on payments link' do
    user = create(:user, :with_residence)
    unit = user.current_unit
    user.update(stripe_account_guid: 'blak')
    user.properties.last.company.update_attributes!(stripe_account_guid: 'blah')
    payment = create(:payment, :error,
           unit: unit,
           user: user,
           amount: 100_000)
    create(:charge_event, payment: payment)

    login_as(user, scope: :user)

    visit payments_path

    expect(page).to have_css('table.payments')
    expect(page).to have_css('tbody tr', count: 1)

    click_on("More Information")

    expect(page).to have_css('table.charge-events')
  end
end


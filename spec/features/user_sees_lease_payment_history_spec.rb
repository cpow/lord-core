require 'rails_helper'

feature 'user sees lease payment history', js: true do
  scenario 'when rent has some payments on a lease payment' do
    user = create(:user, :with_residence)
    unit = user.current_unit
    lease = create(:lease, unit: unit)
    lease_payment = create(:lease_payment, lease: lease, unit: unit)

    create(:payment, unit: unit, user: user, lease_payment: lease_payment)
    create(:payment, :error,
           unit: unit,
           user: user,
           lease_payment: lease_payment,
           amount: 100_000)
    create(:payment, :successful,
           unit: unit,
           user: user,
           lease_payment:
           lease_payment,
           amount: 25_000)

    login_as(user, scope: :user)
    visit user_lease_payment_path(lease_payment)

    expect(page).to have_css('.card.payment', count: 3)
  end
end

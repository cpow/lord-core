require 'rails_helper'

feature 'property manager sees line items', js: true do
  scenario 'by seeing payments as well' do
    manager = create(:property_manager, :with_company)
    property = create(:property, company: manager.company)
    unit = create(:unit, property: property)
    user = create(:user)
    create(:residency,
           unit: unit,
           property: property,
           company: manager.company,
           user: user)
    lease = create(:lease, :with_payment)
    lease_payment = lease.lease_payments.first
    payment = create(
      :payment, unit: unit, user: user, lease_payment: lease_payment
    )
    line_item = create(:line_item, itemable: payment, company: manager.company)

    login_as(manager, scope: :property_manager)
    visit root_path

    expect(page).to have_css('.card.line-items-info')

    find(:css, '.card.line-items-info').click

    expect(page).to have_content(line_item.id)

    find(:css, 'tbody td', text: line_item.id).click

    expect(current_path).to eq(
      property_unit_lease_payment_path(property, unit, lease_payment)
    )
  end
end

require 'rails_helper'

feature 'property manager creates a new resident' do
  scenario 'from the property\'s unit\'s page' do
    manager = create(:property_manager, :with_company)
    login_as(manager, scope: :property_manager)
    property = create(:property, company: manager.company)
    unit = create(:unit, property: property)

    visit property_unit_path(property, unit)
    expect(page).to have_css('.new-property-unit-resident__button')
    click_on(class: 'new-property-unit-resident__button')

    expect(page).to have_css('form')

    fill_in('residency[user_email]', with: 'something@example.com')
    click_on(class: 'btn-primary')

    expect(page).to have_css('.alert.alert-success')

    expect(current_path).to eq(property_unit_path(property, unit))
  end
end

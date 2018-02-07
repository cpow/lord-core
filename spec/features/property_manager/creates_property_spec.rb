require 'rails_helper'

feature 'property manager creates a property', js: true do
  before do
    login_as(create(:property_manager, :with_company), scope: :property_manager)
    visit root_path
  end

  scenario 'by clicking on the new property button on the dashboard' do
    property_name = 'something'
    click_on(class: 'new-property__button')
    expect(page).to have_css('.new-property__form')

    fill_in('Property Name', with: property_name)
    fill_in('Address', with: '34 brittin ave')
    fill_in('City', with: 'Bridgeport')
    select('Connecticut', from: 'property[address_state]')
    fill_in('Zip Code', with: '06605')

    click_on(class: 'property__submit')

    expect(page).to have_content(property_name)
  end
end

require 'rails_helper'

feature 'property manager creates a units', js: true do
  scenario 'by clicking on the new unit button after creating a property' do
    manager = create(:property_manager, :with_company)
    login_as(manager, scope: :property_manager)
    property = create(:property, company: manager.company)

    visit root_path
    find("#property_#{property.id}").click
    expect(current_path).to eq(property_path(property))

    click_on(class: 'new-property-unit__link')
    expect(current_path).to eq(new_property_unit_path(property))
  end
end

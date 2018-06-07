require 'rails_helper'

feature 'property manager creates an expense', js: true do
  scenario 'by navigating to the new expense route' do
    manager = create(:property_manager, :with_company)
    login_as(manager, scope: :property_manager)
    property = create(:property, company: manager.company)

    visit new_expense_path

    select('Property', from: 'expenseable_type')
    click_on('Submit')

    expect(page).to have_css('form.full-form')

    select(property.name, from: 'expenseable_id')
    fill_in('amount', with: 1234)
    fill_in('description', with: 'Something')

    click_on('Submit')

    expect(current_path).to eq(line_items_path)
    expect(page).to have_css('.alert.alert-success')
  end
end


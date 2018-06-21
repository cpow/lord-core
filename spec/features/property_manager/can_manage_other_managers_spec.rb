require 'rails_helper'

feature 'property manager can manage other managers' do
  scenario 'by showing them' do
    manager = create(:property_manager, :with_company, admin: true)
    login_as(manager, scope: :property_manager)
    visit root_path

    click_on(class: 'card company-info')

    expect(current_path).to eq(company_path(manager.company))
    expect(page).to have_css('table')

    within(first("table tbody tr")) do
      click_on(class: 'manager-show__link')
    end

    expect(current_path).to eq(
      company_property_manager_path(manager.company, manager)
    )
  end
end

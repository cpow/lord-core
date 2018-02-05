require 'rails_helper'

feature 'property manager sees dashboard', js: true do
  scenario 'something' do
    visit root_path
    expect(page).to have_content('sign in')
  end

  context 'without any initial setup' do
    before do
      login_as(create(:property_manager, :with_company), scope: :property_manager)
      visit root_path
    end

    scenario 'the manager will see the initial landing page' do
      expect(page).to have_css('.card.bank-info')
      expect(page).to have_css('.card.account-info')
      expect(page).to have_css('.card.company-info')
    end

    scenario 'the manager will see a notice to provide banking information' do
      expect(page).to have_css('.bank-warning')
    end

    scenario 'the manager will see no residents, units, etc...' do
      click_on("Residents")
      expect(page).to have_css('.no-resident-warning')
      visit(root_path)

      click_on("Units")
      expect(page).to have_css('.no-unit-warning')
    end
  end
end

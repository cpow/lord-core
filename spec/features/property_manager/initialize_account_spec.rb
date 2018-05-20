require 'rails_helper'

feature 'property manager initializes their account' do
  scenario 'by correctly adding their password' do
    manager = create(:property_manager, active: false)
    visit(new_property_manager_initializer_path(manager))

    expect(page).to have_css('form')

    fill_in('password', with: 'test1234')
    fill_in('password_confirmation', with: 'test1234')

    click_on('Activate Account')

    expect(current_path).to eq(new_property_manager_session_path)
  end

  scenario 'will redirect if active' do
    manager = create(:property_manager, active: true)
    visit(new_property_manager_initializer_path(manager))
    expect(current_path).to eq(new_property_manager_session_path)
  end
end

require 'rails_helper'

feature 'user sees dashboard', js: true do
  scenario 'something' do
    visit root_path
    expect(page).to have_content('sign in')
  end
end

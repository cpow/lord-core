require 'rails_helper'

feature 'user reports an issue', js: true do
  scenario 'from the user dashboard' do
    allow_any_instance_of(ActionController::Base).to receive(:protect_against_forgery?).and_return(true)
    user = create(:user, :with_residence)
    login_as(user, scope: :user)
    visit root_path

    click_on('issues__link')
    expect(page).to have_css('.new-issue__button')

    click_on(class: 'new-issue__button')
    expect(page).to have_css('form.new-issue__form')

    fill_in('description', with: 'this is a comment')

    click_on(class: 'next-link')
    expect(page).to have_css('.dropzone')

    click_on(class: 'next-link')
    expect(page).to have_css('#description')
  end
end

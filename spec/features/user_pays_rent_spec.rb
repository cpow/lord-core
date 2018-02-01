require 'rails_helper'
include ActionView::Helpers::NumberHelper

feature 'user pays rent', js: true do
  scenario 'but cannot when property doesnt have an account set up' do
    user = create(:user, :with_residence)

    login_as(user, scope: :user)
    visit root_path

    click_on('pay-lease__link')

    expect(current_path).to eq('/')
    expect(page).to have_css('.alert')
  end

  scenario 'but cannot when THEY dont have an account' do
    user = create(:user, :with_residence)
    user.properties.last.company.update_attributes!(stripe_account_guid: 'blah')

    login_as(user, scope: :user)
    visit root_path

    click_on('pay-lease__link')

    expect(current_path).to eq('/')
    expect(page).to have_css('.alert')
  end

  scenario 'by clicking on the link, and paying without lease' do
    user = create(:user, :with_residence)
    user.update_attributes(stripe_account_guid: 'blak')
    user.properties.last.company.update_attributes!(stripe_account_guid: 'blah')

    login_as(user, scope: :user)
    visit root_path

    click_on('pay-lease__link')
    fill_in(:rentAmount, with: '1234')
    click_button('Create Payment')

    expect(page).to have_css('#submitAfterConfirm')

    click_on('submitAfterConfirm')

    expect(current_path).to eq('/')
  end

  scenario 'by clicking on the link, and paying with a lease' do
    user = create(:user, :with_residence)
    user.update_attributes(stripe_account_guid: 'blak')
    user.properties.last.company.update_attributes!(stripe_account_guid: 'blah')
    lease = create(:lease, unit: user.units.last)
    lease_payment = create(:lease_payment, lease: lease, unit: user.units.last)

    login_as(user, scope: :user)
    visit root_path

    click_on('pay-lease__link')

    expect(page).to have_content(number_to_currency(lease_payment.human_amount_due))

    fill_in(:rentAmount, with: '1234')
    click_button('Create Payment')

    expect(page).to have_css('#submitAfterConfirm')

    click_on('submitAfterConfirm')

    expect(current_path).to eq(user_lease_path(user, lease))
  end

  scenario 'it doesn\'t allow decimals' do
    user = create(:user, :with_residence)
    user.update_attributes(stripe_account_guid: 'blak')
    user.properties.last.company.update_attributes!(stripe_account_guid: 'blah')
    lease = create(:lease, unit: user.units.last)
    lease_payment = create(:lease_payment, lease: lease, unit: user.units.last)

    login_as(user, scope: :user)
    visit root_path

    click_on('pay-lease__link')

    fill_in(:rentAmount, with: '1234.123')
    click_button('Create Payment')

    expect(page).to have_css('#submitAfterConfirm')

    click_on('submitAfterConfirm')

    expect(current_path).to eq(user_lease_path(user, lease))
    expect(page).to have_content('1,234')
  end
end

require 'rails_helper'

feature 'user sees dashboard', js: true do
  scenario 'something' do
    visit root_path
    expect(page).to have_content('sign in')
  end

  context 'without a lease payment or lease' do
    before do
      login_as(create(:user), scope: :user)
      visit root_path
    end

    scenario 'the user will still see a normal dashboard' do
      expect(page).to have_css('.card.banking')
      expect(page).to have_css('.card.lease-info')
      expect(page).to have_css('.card.rent-info')
    end

    scenario 'the user will see message saying no lease yet' do
      expect(page).to have_content('Your property manager hasn\'t')
    end
  end

  context 'with a property' do
    scenario 'the user will see property information at the bottom' do
      user = create(:user, :with_residence)

      login_as(user, scope: :user)
      visit root_path

      expect(page).to have_css('.card.residence-info')
    end
  end

  context 'paying rent' do
    scenario 'should be a danger when the user is late for rent' do
      user = create(:user, :with_late_lease_payment)

      login_as(user, scope: :user)
      visit root_path

      expect(page).to have_css('.card.rent-info')
      expect(page).to have_css('.card.rent-info.alert-danger')
    end

    scenario 'should be a info when the user is reminded for rent' do
      user = create(:user, :with_reminder_lease_payment)

      login_as(user, scope: :user)
      visit root_path

      expect(page).to have_css('.card.rent-info.alert-info')
    end

    scenario 'should be a warning when rent is due' do
      user = create(:user, :with_due_lease_payment)

      login_as(user, scope: :user)
      visit root_path

      expect(page).to have_css('.card.rent-info.alert-warning')
    end
  end
end

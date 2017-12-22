require 'rails_helper'

feature 'user edits information', js: true do
  context 'entering correct information' do
    scenario 'the user will see confirmation that they changed the info' do
      user = create(:user)
      login_as(user, scope: :user)
      visit edit_user_path(user)

      fill_in :user_name, with: 'somebody else'
      click_button 'Update User'

      expect(page).to have_content('Success!')
      expect(current_path).to eq(user_path(user))
    end
  end
end

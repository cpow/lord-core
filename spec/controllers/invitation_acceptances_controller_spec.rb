require 'rails_helper'

RSpec.describe InvitationAcceptancesController do
  describe '#create' do
    it 'will respond with success if not valid' do
      user = create(:user)
      post :create, params: { user_id: user.invite_token, user: { password: '1234' } }

      expect(response).to be_success
    end

    it 'will redirect if valid' do
      user = create(:user)
      params = { password: 'test12345', password_confirmation: 'test12345' }
      post :create, params: { user_id: user.invite_token, user: params }

      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
